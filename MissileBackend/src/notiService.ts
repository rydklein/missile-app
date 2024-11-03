import apn from '@parse/node-apn'
import dotenv from 'dotenv'
import { PrismaClient } from '@prisma/client'

dotenv.config()
const prisma = new PrismaClient()

const options: apn.ProviderOptions = {
  token: {
    key: "./key.p8",
    keyId: process.env.KEY_ID!,
    teamId: process.env.TEAM_ID!,
  },
  production: false,
};

const apnProvider = new apn.Provider(options);

async function sendActionNotification() {
    const notification = new apn.Notification()
    notification.topic = process.env.APP_BUNDLE!
    notification.aps = { "content-available": 1 }

    notification.payload = {
        updateType: "missileLocationUpdate",
    } 

    try {
        const users = await prisma.user.findMany({
            select: {
                device_token: true,
            },
        })

        const deviceTokens = users.map(user => user.device_token)

        apnProvider.send(notification, deviceTokens).then((response) => {
            console.log("Notification sent successfully", response)
        })
    } catch (error) {
        console.error("Error fetching device tokens or sending notification:", error)
    }
}

export async function sendMissileNotification(usersInRange: number[]) {
    try {
        const allUsers = await prisma.user.findMany({
            select: { id: true, device_token: true }
        })

        const inRangeUsers = allUsers.filter(user => usersInRange.includes(user.id))
        const outOfRangeUsers = allUsers.filter(user => !usersInRange.includes(user.id))

        const inRangeNotification = new apn.Notification()
        inRangeNotification.topic = process.env.APP_BUNDLE!
        inRangeNotification.alert = "Someone launched a magic missile, but not to worry -- you're safe."
        inRangeNotification.payload = { updateType: "missileInRange" }

        const outOfRangeNotification = new apn.Notification()
        outOfRangeNotification.topic = process.env.APP_BUNDLE!
        outOfRangeNotification.alert = "Someone launched a magic missile -- you're in the blast zone!"
        outOfRangeNotification.payload = { updateType: "missileOutOfRange" }

        const inRangeDeviceTokens = inRangeUsers.map(user => user.device_token)
        await apnProvider.send(inRangeNotification, inRangeDeviceTokens)

        const outOfRangeDeviceTokens = outOfRangeUsers.map(user => user.device_token)
        await apnProvider.send(outOfRangeNotification, outOfRangeDeviceTokens)

    } catch (error) {
        console.error("Error fetching device tokens or sending notifications:", error)
    }
}


process.on('exit', () => {
    apnProvider.shutdown()
  })
