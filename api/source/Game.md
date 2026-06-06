# Game    

包含所有游戏信息的主要全局游戏对象。


{% api_property Game.constructionSites 'object&lt;string, <a href="#ConstructionSite">ConstructionSite</a>&gt;' %}


包含你所有施工工地的 hash，并以 id 作为关键字。


{% api_property Game.cpu 'object' %}


表示 CPU 使用率和方法的全局对象。 请参照此[文档](#Game-cpu)


{% api_property Game.creeps 'object&lt;string, <a href="#Creep">Creep</a>&gt;' %}

```javascript
for(const i in Game.creeps) {
    Game.creeps[i].moveTo(flag);
}
```

包含你所有 creep 的 hash，并以 creep 名作为关键字。


{% api_property Game.flags 'object&lt;string, <a href="#Flag">Flag</a>&gt;' %}

```javascript
creep.moveTo(Game.flags.Flag1);
```

包含你所有 flag 的 hash，以 flag 名作为关键字。


{% api_property Game.gcl 'object' %}


你的<a href="/control.html#Global-Control-Level">全局控制等级（Global Control Level）</a>的对象，具有以下属性：

{% api_method_params %}
level : number
当前的等级。
===
progress : number
到下一个等级当前的进展。
===
progressTotal : number
到下一个等级所需的进展。
{% endapi_method_params %}

{% api_property Game.gpl 'object' %}

你的全局能量等级（Global Power Level）</a>的对象，具有以下属性：

{% api_method_params %}
level : number
当前的等级。
===
progress : number
到下一个等级当前的进展。
===
progressTotal : number
到下一个等级所需的进展。
{% endapi_method_params %}


{% api_property Game.map object %}


表示世界地图的全局对象。 请参照此[文档](#Game-map)。


{% api_property Game.market object %}


表示游戏内市场的全局对象。 请参照此[文档](#Game-market) 


{% api_property Game.powerCreeps 'object&lt;string, <a href="#PowerCreep">PowerCreep</a>&gt;' %}

```javascript
Game.powerCreeps['PC1'].moveTo(flag);
```

包含你所有超能 creep 的 hash，以 creep 名称为键。从这里也可以访问到未孵化的超能 creep。 


{% api_property Game.resources 'object' %}


表示你账户中全局资源的对象，例如 pixel 或 cpu unlock。每个对象的关键字都是一个资源常量，值是资源量。


{% api_property Game.rooms 'object&lt;string, <a href="#Room">Room</a>&gt;' %}


包含所有对你可用的房间的 hash，以房间名作为关键字。一个房间在你有一个 creep 或者自有建筑在其中时可见。


{% api_property Game.shard 'object' %}

表示当前执行脚本 shard 的全局对象。 请参照此[文档](#Game-shard)

{% api_property Game.spawns 'object&lt;string, <a href="#StructureSpawn">StructureSpawn</a>&gt;' %}

```javascript
for(const i in Game.spawns) {
    Game.spawns[i].createCreep(body);
}
```

包含你所有 spawn 的 hash，以 spawn 名作为关键字。


{% api_property Game.structures 'object&lt;string, <a href="#Structure">Structure</a>&gt;' %}


包含你所有 structures 的 hash，以 structures 名作为关键字。


{% api_property Game.time 'number' %}

```javascript
console.log(Game.time);
```

系统游戏 tick 计数。他在每个 tick 自动递增。点此<a href="/game-loop.html">了解更多</a>。

{% api_method Game.getObjectById 'id' 1 %}

```javascript
creep.memory.sourceId = creep.pos.findClosestByRange(FIND_SOURCES).id;
const source = Game.getObjectById(creep.memory.sourceId);
```

获取具有唯一指定 ID 的对象。 它可以是任何类型的游戏对象。 只能访问您可见的房间内的物体。

{% api_method_params %}
id : string
唯一 ID。
{% endapi_method_params %}


### 返回值

返回一个对象实例，若找不到则返回 null。

{% api_method Game.notify 'message, [groupInterval]' A %}

```javascript
if(creep.hits < creep.memory.lastHits) {
    Game.notify('Creep '+creep+' has been attacked at '+creep.pos+'!');
}
creep.memory.lastHits = creep.hits;
```

```javascript
if(Game.spawns['Spawn1'].energy == 0) {
    Game.notify(
        'Spawn1 is out of energy',
        180  // group these notifications for 3 hours
    );
}

```

向你的个人资料中的邮件发送信息。由此，你可以在游戏中的任何场合为自己设置通知。你最多可以安排 20 个通知。在模拟模式中不可用。

{% api_method_params %}
message : string
将在消息中发送的自定义文本。最大长度为 1000 个字符。
===
groupInterval : number
如果被设为 0 (默认), 通知将被立即安排。 否早他将于其他通知编组，并在指定的时间（分钟）寄出。
{% endapi_method_params %}
