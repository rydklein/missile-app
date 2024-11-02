import apn from '@parse/node-apn'
import cron from 'node-cron';
import dotenv from 'dotenv'
import { PrismaClient } from '@prisma/client'

dotenv.config()
const prisma = new PrismaClient()


const options: apn.ProviderOptions = {
  token: {
    key: "./path",
    keyId: "YOUR_KEY_ID",
    teamId: "YOUR_TEAM_ID",
  },
  production: false,
};

const apnProvider = new apn.Provider(options);

export const startDailyMissileNotification = () => {
    cron.schedule('0 9 * * *', async () => {
      await sendActionNotification()
    }, {
      timezone: 'America/New_York',
    })
  }

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

export async function sendMissileNotification( usersInRange ){
    try {
        const inRangeUser = await prisma.user.findMany({
            where: {
                id: { in: usersInRange },
            },
        })


    } catch (error) {
        console.error("Error fetching device tokens or sending notification:", error)
    }
}




process.on('exit', () => {
    apnProvider.shutdown()
  })
