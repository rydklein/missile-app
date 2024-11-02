import express, { Request, Response } from 'express'
import dotenv from 'dotenv'
import userRoutes from './routes/userRoutes'
import { PrismaClient } from '@prisma/client'

dotenv.config()
const app = express()
const prisma = new PrismaClient()

app.use('/users', userRoutes)


app.get('/', (req: Request, res: Response) => {
  res.send('Hello World!')
})

process.on('SIGINT', async () => {
    await prisma.$disconnect()
    process.exit(0)
  })

const port = process.env.PORT || 3000
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`)
})
