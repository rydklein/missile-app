import { Router, Request, Response } from "express";
import { PrismaClient } from "@prisma/client";

const router = Router();
const prisma = new PrismaClient();

router.get("/", async (req, res) => {
  try {
    const users = await prisma.user.findMany();
    res.status(200).json(users);
  } catch (error) {
    res.status(500).json({ error: "Error fetching posts" });
  }
});

  router.post('/', async (req: Request, res: Response) => {
    const { deviceIdentifier, deviceToken, userName, gameId } = req.body

    try {
        const user = await prisma.user.upsert({
            where: { id: deviceIdentifier },
            update: {
                device_token: deviceToken,
                name: userName || null,
                gameId: gameId || null,
            },
            create: {
                id: deviceIdentifier,
                device_token: deviceToken,
                name: userName || null,
                gameId: gameId || null,
            },
        })

        res.status(201).json(user)
    } catch (error) {
        res.status(500).json({ error: 'Error creating or updating user' })
    }
})



export default router
