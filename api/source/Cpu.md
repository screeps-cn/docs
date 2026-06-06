# Game.cpu

一个包含 CPU 使用情况的全局对象。


{% api_property Game.cpu.limit 'number' %}



你在当前指定 shard 的CPU限制。



{% api_property Game.cpu.tickLimit 'number' %}



当前游戏 tick 可用的 CPU 时间。 通常它高于 <code>Game.cpu.limit</code>。 <a href="/cpu-limit.html">了解更多</a>



{% api_property Game.cpu.bucket 'number' %}



在你的 <a href="/cpu-limit.html#Bucket">bucket</a> 中累积的未使用的 CPU 数量。



{% api_property 'Game.cpu.shardLimits' 'object&lt;string,number&gt;' %}



包含了每个 shard cpu 上限的对象，以 shard 名称为关键字。你可以使用 [`setShardLimits`](#Game.cpu.setShardLimits) 方法重设他们。



{% api_property Game.cpu.unlocked 'boolean' %}



您的账户是否已经解锁了完整的 CPU。



{% api_property Game.cpu.unlockedTime 'number' %}



您账户解锁完整 CPU 时的 <a href="https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime#Syntax">UNIX 毫秒时间戳</a> 当您账户的完整 CPU 未解锁或未使用 subscription 时该属性未定义。



{% api_method Game.cpu.getHeapStatistics '' 1 %}

```javascript
let heap = Game.cpu.getHeapStatistics();
console.log(`Used ${heap.total_heap_size} / ${heap.heap_size_limit}`);
```

使用此方法获取虚拟机的堆统计信息。 返回值几乎与 Node.js 函数 [`v8.getHeapStatistics()`](https://nodejs.org/dist/latest-v8.x/docs/api/v8.html#v8_v8_getheapstatistics) 相同。 此函数返回一个附加属性：`externally_allocated_size`，它是当前分配的内存总量，不包含在 v8 堆中，但会计入此隔离的内存限制。超过一定大小的 `ArrayBuffer` 实例是外部分配的，将在此计算。


### 返回值

以下列格式返回具有堆统计信息的对象：

```javascript-content
{
  "total_heap_size": 29085696,
  "total_heap_size_executable": 3670016,
  "total_physical_size": 26447928,
  "total_available_size": 319649520,
  "used_heap_size": 17493824,
  "heap_size_limit": 343932928,
  "malloced_memory": 8192,
  "peak_malloced_memory": 1060096,
  "does_zap_garbage": 0,
  "externally_allocated_size": 38430000
}
```


{% api_method Game.cpu.getUsed '' 1 %}

```javascript
if(Game.cpu.getUsed() > Game.cpu.tickLimit / 2) {
    console.log("Used half of CPU already!");
}
```

```javascript
for(const name in Game.creeps) {
    const startCpu = Game.cpu.getUsed();

    // creep logic goes here

    const elapsed = Game.cpu.getUsed() - startCpu;
    console.log('Creep '+name+' has used '+elapsed+' CPU time');
}

```

获取当前游戏开始时使用的 CPU 时间总量。在模拟模式下始终返回 0.


### 返回值

以浮点数返回当前使用的 CPU 时间。


{% api_method Game.cpu.halt '' 1 %}

```javascript
Game.cpu.halt();
```

重置你的运行环境并擦除堆内存中的所有数据。

{% api_method Game.cpu.setShardLimits 'limits' 1 %}

```javascript
Game.cpu.setShardLimits({shard0: 20, shard1: 10});
```

分配 CPU 限制到不同的 shard。CPU总量应保持等于
 [`Game.cpu.shardLimits`](#Game.cpu.shardLimits)。 此方法每 12 小时只能使用一次。
{% api_method_params %}
limits : object&lt;string, number&gt;
表示每个 shard 的 CPU 值，与 `Game.cpu.shardLimits` 格式相同。
{% endapi_method_params %}


### 返回值

如下错误码之一:
{% api_return_codes %}
OK | 这个操作已经成功纳入计划。
ERR_BUSY | 12 小时的冷却时间尚未结束。
ERR_INVALID_ARGS | 该参数不是有效的 shard 限制对象。
{% endapi_return_codes %}


{% api_method Game.cpu.unlock '' 1 %}

```javascript
if(Game.cpu.unlockedTime && ((Game.cpu.unlockedTime - Date.now()) < 1000*60*60*24)) {
    Game.cpu.unlock();
}
```

为您的账户解锁 24 小时的完整 CPU。该方法将消耗一个您账户中的 CPU unlock（详见 [`Game.resources`](#Game.resources)）。
如果之前尚未激活过完整 CPU。则可能需要一点时间（5 分钟之内）来为您的账户应用解锁。

### 返回值

如下错误码之一:
{% api_return_codes %}
OK | 这个操作已经成功纳入计划。
ERR_FULL | 您的 CPU 已经使用了 subscription 解锁。
ERR_NOT_ENOUGH_RESOURCES | 您的帐户没有足够的 `cpuUnlock` 资源。
{% endapi_return_codes %}

{% api_method Game.cpu.generatePixel '' 3 %}

```javascript
if(Game.cpu.bucket == 10000) {
    Game.cpu.generatePixel();
}
```

从您的 bucket 中取出 10000 CPU 来生成一点 pixel 资源。

### 返回值

如下错误码之一:
{% api_return_codes %}
OK | 这个操作已经成功纳入计划。
ERR_NOT_ENOUGH_RESOURCES | 您的 bucket 中没有足够的 CPU。
{% endapi_return_codes %}
