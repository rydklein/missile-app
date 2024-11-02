import { Router, Request, Response } from 'express'
import { PrismaClient } from '@prisma/client'

const router = Router()
const prisma = new PrismaClient()

router.get('/', async (req, res) => {
    try {
      const users = await prisma.user.findMany()
      res.status(200).json(users)
    } catch (error) {
      res.status(500).json({ error: 'Error fetching posts' })
    }
  })

router.post('/', async (req: Request, res: Response) => {
    const { deviceIdentifier, deviceToken } = req.body;

    try {
        const user = await prisma.user.create({
          data: { id: deviceIdentifier, device_token: deviceToken, name: null },
        })
        res.status(201).json(user)
      } catch (error) {
        res.status(500).json({ error: 'Error creating user' })
      }
})

router.put('/', async (req: Request, res: Response) => {
    const { deviceIdentifier, deviceToken, userName } = req.body;

    try {
        const data: { name?: string; deviceToken?: string } = {}

        if (userName) {
            data.name = userName
        }
        if (deviceToken) {
            data.deviceToken = deviceToken
        }

        const user = await prisma.user.update({
            where: {
                id: deviceIdentifier,
              },
              data
        })
        res.status(200).json(user)
      } catch (error) {
        res.status(500).json({ error: 'Error updating user' })
      }
})


export default router;
