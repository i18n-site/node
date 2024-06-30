> @3-/pgw
  @3-/ipreq/fTxt.js
  @3-/utf8/utf8e.js

vpsLiRefreshId = (PG, vps_li)=>
  vps_refresh = new Map await PG"SELECT id,refresh_id FROM cdn.vps_refresh WHERE id IN #{
    PG vps_li.map ([id])=>id
  }".values()
  for i from vps_li
    i.push vps_refresh.get(i[0]) or 0
  return

vpsIdLi = (PG,VPS_LI)=>
  vps_name_li = [...Object.keys VPS_LI]
  vps_id = new Map await PG"SELECT name,id FROM cdn.vps WHERE name IN #{
    PG vps_name_li
  }".values()

  not_exist = []
  vps_li = []
  for i from vps_name_li
    id = vps_id.get i
    if id
      vps_li.push [id,i,VPS_LI[i]]
    else
      not_exist.push i

  for vps from not_exist
    [[id]] = await PG"INSERT INTO cdn.vps (name)VALUES(#{vps}) RETURNING id".values()
    vps_li.push [
      id,vps,VPS_LI[vps]
    ]
  vps_li

< (conf)=>
  {
    AUTH
    VPS_LI
    HOST
    PG_URL
  } = await import(conf)

  PG = pgw(
    PG_URL
    # debug: console.log
  )
###
  .replace(
    # pooler 不会收到 listen 的信息
    '-pooler.', '.'
  )
###
  AUTH = Buffer.from(
    utf8e(
      AUTH
    )
  ).toString('base64')

  _refresh = (refresh_id, vps)=>
    if not refresh_id
      return
    [id, name, ip, pre_refresh_id] = vps
    # if refresh_id == 1+pre_refresh_id
    #   id_li = [refresh_id]
    path_li = new Set (await PG"SELECT name FROM cdn.pkg,cdn.refresh r WHERE pkg_id=cdn.pkg.id AND r.id<=#{refresh_id} AND r.id>#{pre_refresh_id}".values()).map(([name])=>name)
    for path from path_li
      console.log refresh_id, name,'https://'+HOST+'/'+path
      r = await fTxt(
        HOST
        path
        ip
        {
          method: 'POST'
          headers: {
            'Authorization': 'Basic '+AUTH
          }
        }
      )
      if r[2] != 200
        throw r

    vps[3] = refresh_id
    await PG"INSERT INTO cdn.vps_refresh (id,refresh_id,ts) VALUES (#{id},#{refresh_id},EXTRACT(EPOCH FROM NOW())::bigint) ON CONFLICT (id) DO UPDATE SET refresh_id=EXCLUDED.refresh_id,ts=EXCLUDED.ts; "
    return

  refresh = (refresh_id, vps)=>
    try
      await _refresh(refresh_id, vps)
    catch e
      console.error e
    return


  vps_li = await vpsIdLi(PG,VPS_LI)
  await vpsLiRefreshId(PG, vps_li)

  await PG.listen(
    'refresh_pkg'
    (id)=>
      for i from vps_li
        await refresh(id, i)
      return
    =>
      global.gc()
      console.log 'RSS', Math.round((process.memoryUsage().rss*100/1048576)/100)+'MB'
      [t] = await PG"SELECT id FROM cdn.refresh ORDER BY ID DESC LIMIT 1".values()
      if not t
        return
      refresh_id = t[0]
      for i from vps_li
        if refresh_id != i[3]
          await refresh(refresh_id, i)
      return
  )
  return

