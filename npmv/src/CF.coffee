class CloudflareApiError extends Error
  constructor: (msg) ->
    super(msg)
    @name = 'CloudflareApiError'

api = (
  {
    CF_TOKEN
    CF_MAIL
  }
  url, opt = {}
) ->
  opt.headers =
    'X-Auth-Key': CF_TOKEN
    'X-Auth-Email': CF_MAIL
    # 'Authorization': "Bearer #{TOKEN}"
    'Content-Type': 'application/json'

  if opt.body
    opt.body = JSON.stringify(opt.body)

  response = await fetch(
    'https://api.cloudflare.com/client/v4/'+url
    opt
  )
  data = await response.json()
  if not data.success
    throw new CloudflareApiError(
      JSON.stringify(data)
    )
  data

export purgeCache = (env, url) =>
  {
    CF_ZONE_ID
    CF_HOST_LI
  }=env

  api(
    env
    "zones/#{CF_ZONE_ID}/purge_cache"
    {
      method: 'POST'
      body: {
        files:CF_HOST_LI.split(' ').map(
          (host)=> "https://#{host}/#{url}"
        )
      }
    }
  )
