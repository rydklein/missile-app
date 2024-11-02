import { Router, Request, Response } from 'express'
import { PrismaClient } from '@prisma/client'

const router = Router()
const prisma = new PrismaClient()

router.post('/', async (req: Request, res: Response) => {
    try {
        const newGame = await prisma.game.create({
            data: {},
        })
        
        res.status(201).json(newGame)
    } catch (error) {
        res.status(500).json({ error: 'Error creating game' })
    }
})

