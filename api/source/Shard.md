# Game.shard

描述当前执行脚本的 shard 对象。


{% api_property Game.shard.name 'string' %}



shard 的名称。



{% api_property Game.shard.type 'string' %}



目前总是等于 `normal`.



{% api_property Game.shard.ptr 'boolean' %}



这个 shard 是否属于 [PTR](/ptr.html).



{% api_property Game.shard.access 'boolean' %}



您当前是否有访问此 shard 的权限。 在非限制性 shard 上总是 `true`。在限制性 shards 上, 需要激活 [`ACCESS_KEY`](#Constants) 资源或激活无限访问权限。 使用 [`Game.shard.activateAccess`](#Game.shard.activateAccess) 激活访问。


{% api_property Game.shard.accessTime 'number' %}



这个 <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime#Syntax">UNIX毫秒时间戳</a> 为激活访问权限的时间。 无访问限制的 shard 或未激活访问权限时此属性未被定义。



{% api_method Game.shard.activateAccess '' 1 %}

```javascript
if(Game.shard.access && Game.shard.accessTime && ((Game.shard.accessTime - Date.now()) < 1000*60*60*24*7)) {
    Game.shard.activateAccess();
}
```

激活对当前受限 shard 30天的访问授权。 此方法将消耗一个 [`ACCESS_KEY`](#Constants) 资源，具体信息参阅 [`Game.resources`](#Game.resources)。 这个方法仅适用于受限的 shard (定义 `Game.shard.access` 时).

### 返回值

如下错误码之一:
{% api_return_codes %}
OK | 这个操作已经成功纳入计划。
ERR_INVALID_TARGET | 这个 shard 不受限。
ERR_FULL | 你的访问权限是无限的。
ERR_NOT_ENOUGH_RESOURCES | 你账户中的 `accessKey` 资源不足。
{% endapi_return_codes %}
