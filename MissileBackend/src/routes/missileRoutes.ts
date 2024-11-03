import { Router, Request, Response } from 'express'
import { PrismaClient } from '@prisma/client'
import { isBetween10and6EST } from '../utils/timeUtils'
import { sendMissileNotification } from '../notiService'

const router = Router()
const prisma = new PrismaClient()

router.get('/', async (req: Request, res: Response) => {  
    try {
      const missiles = await prisma.object.findMany({
        where: {
          type: 'missile',
        },
      })
      res.status(200).json(missiles)
    } catch (error) {
      res.status(500).json({ error: 'Error fetching missiles' })
    }
  })

  
  router.post('/', async (req: Request, res: Response) => {
    const { lat, long, ownerId } = req.body
  
    if (!lat || !long || !ownerId) {
      res.status(400).json({ error: 'lat, long, and ownerId are required' })
      return
    }
  
    try {
      const newMissile = await prisma.object.create({
        data: {
          lat,
          long,
          type: 'missile', 
          launched: false,
          owner: { connect: { id: ownerId } },
        },
      })
      res.status(201).json(newMissile)
    } catch (error) {
      res.status(500).json({ error: 'Error creating missile' })
    }
  })

  router.post('/inRange', async (req: Request, res: Response) => {
    const { missileId, userId, inRange } = req.body
  
    if (!missileId || !userId || inRange === undefined) {
      res.status(400).json({ error: 'missileId, userId, and inRange are required' })
      return
    }
  
    try {
      const rangeEntry = await prisma.missileRange.upsert({
        where: {
          userId_missileId: {
            userId,
            missileId,
          },
        },
        update: {
          inRange,
        },
        create: {
          missile: { connect: { id: missileId } },
          user: { connect: { id: userId } },
          inRange,
        },
      })
    
      res.status(200).json(rangeEntry)
    } catch (error) {
      res.status(500).json({ error: 'Error creating or updating missile range' })
    }
})

  router.put('/:missileId', async (req: Request, res: Response) => {
    const { missileId } = req.params

    try {
        const updateData: any = {}

        if (isBetween10and6EST()) {
            updateData.launched = true
            const updatedMissile = await prisma.object.update({
                where: { id: Number(missileId) },
                data: updateData,

            })
            // TODO: Send notifications to all users. If they're currently in range of the missile, they shoudl get a different notification.
            const ranges = await prisma.missileRange.findMany({
                where: {
                  missileId: Number(missileId),
                },
            })
            
            const userInRange = ranges.map(range => range.userId);
            sendMissileNotification(userInRange)
            
            // This code is run a minute after the missile is launched.
            // loop over all users attached to the missile. If they're in range, take 1 away from their health and set a flag to "hit" on that missile for that user
            setTimeout(async () => {
                
                  
                  for(const range of ranges){
                    if (range.inRange){
                        await prisma.user.update({
                            where: { id: range.userId },
                            data: { health: { decrement: 1 } },
                        })
                    }
                  }
            }, 60000)
            res.status(200).json(updatedMissile)
        }
        else{
            res.status(400).json({ error: 'Cannot Launch During Planning' })
        }

        
    } catch (error) {
        res.status(500).json({ error: 'Error updating missile' })
    }
})
  
  


export default router
