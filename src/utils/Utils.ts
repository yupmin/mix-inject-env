import { Cfg } from '../app/Config'

export function retrieveMixEnvCfg(): Record<string, string> {
  const env = process.env
  const keys = Object.keys(env)
  const mixKeys = keys.filter(key => {
    return key.startsWith(Cfg.PREFIX) || key === 'PUBLIC_URL'
  })

  const envCfg: Record<string, string> = {}
  for (const key of mixKeys) {
    // @ts-ignore
    const matched = process.env[key].match(/^\$\{([A-Z0-9_]*)\}/)

    // @ts-ignore
    envCfg[key] = !matched ? process.env[key] : process.env[matched[1]]
  }
  return envCfg
}

export function retrieveDotEnvCfg(): Record<string, string> {
  // eslint-disable-next-line @typescript-eslint/no-var-requires
  const env = require('dotenv').config().parsed ?? {}

  const keys = Object.keys(env)
  const mixKeys = keys.filter(key => {
    return key.startsWith(Cfg.PREFIX) || key === 'PUBLIC_URL'
  })

  const envCfg: Record<string, string> = {}
  for (const key of mixKeys) {
    // @ts-ignore
    envCfg[key] = process.env[key]
  }
  return envCfg
}
