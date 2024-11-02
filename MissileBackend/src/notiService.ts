import apn from '@parse/node-apn'
import cron from 'node-cron';
import dotenv from 'dotenv'
dotenv.config()

const options: apn.ProviderOptions = {
    token: {
      key: "./path", 
      keyId: "YOUR_KEY_ID", 
      teamId: "YOUR_TEAM_ID", 
    },
    production: false,
  }


const apnProvider = new apn.Provider(options)

export const startDailyMissileNotification = () => {
    cron.schedule('0 9 * * *', async () => {
      await sendMissileNotification()
    }, {
      timezone: 'America/New_York',
    })
  }

async function sendMissileNotification() {
    const notification = new apn.Notification()
    notification.topic = process.env.APP_BUNDLE!
    notification.aps = { "content-available": 1 }

    notification.payload = {
        updateType: "missileLocationUpdate",
      } 
}




process.on('exit', () => {
    apnProvider.shutdown()
  })
