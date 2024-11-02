export function isBetween10and6EST(): boolean {
    const now = new Date()
    const utcHour = now.getUTCHours()
    const estHour = (utcHour - 5 + 24) % 24
    return estHour >= 10 && estHour < 18
  }
  