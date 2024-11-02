import apn from '@parse/node-apn'

const options: apn.ProviderOptions = {
    token: {
      key: "./path", 
      keyId: "YOUR_KEY_ID", 
      teamId: "YOUR_TEAM_ID", 
    },
    production: false,
  }


const apnProvider = new apn.Provider(options)




process.on('exit', () => {
    apnProvider.shutdown()
  })
