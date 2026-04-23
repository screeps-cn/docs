# Game    

The main global game object containing all the game play information.


{% api_property Game.constructionSites 'object&lt;string, <a href="#ConstructionSite">ConstructionSite</a>&gt;' %}



A hash containing all your construction sites with their id as hash keys.



{% api_property Game.cpu 'object' %}



A global object containing information about your CPU usage and methods. See the [documentation](#Game-cpu) below.


{% api_property Game.creeps 'object&lt;string, <a href="#Creep">Creep</a>&gt;' %}

```javascript
for(const i in Game.creeps) {
    Game.creeps[i].moveTo(flag);
}
```

A hash containing all your creeps with creep names as hash keys.



{% api_property Game.flags 'object&lt;string, <a href="#Flag">Flag</a>&gt;' %}

```javascript
creep.moveTo(Game.flags.Flag1);
```

A hash containing all your flags with flag names as hash keys.



{% api_property Game.gcl 'object' %}



Your <a href="/control.html#Global-Control-Level">Global Control Level</a>, an object with the following properties :

{% api_method_params %}
level : number
The current level.
===
progress : number
The current progress to the next level.
===
progressTotal : number
The progress required to reach the next level.
{% endapi_method_params %}

{% api_property Game.gpl 'object' %}

Your Global Power Level, an object with the following properties :

{% api_method_params %}
level : number
The current level.
===
progress : number
The current progress to the next level.
===
progressTotal : number
The progress required to reach the next level.
{% endapi_method_params %}



{% api_property Game.map object %}



A global object representing world map. See the [documentation](#Game-map) below.



{% api_property Game.market object %}



A global object representing the in-game market. See the [documentation](#Game-market) below.


{% api_property Game.powerCreeps 'object&lt;string, <a href="#PowerCreep">PowerCreep</a>&gt;' %}

```javascript
Game.powerCreeps['PC1'].moveTo(flag);
```

A hash containing all your power creeps with their names as hash keys. Even power creeps 
not spawned in the world can be accessed here. 



{% api_property Game.resources 'object' %}



An object with your global resources that are bound to the account, like pixels or cpu unlocks. Each object key is a resource constant, values are resources amounts.



{% api_property Game.rooms 'object&lt;string, <a href="#Room">Room</a>&gt;' %}



A hash containing all the rooms available to you with room names as hash keys. A room is visible if you have a creep or an owned structure in it.

{% api_property Game.shard 'object' %}



A global object describing the world shard where your script is currently being executed in. See the [documentation](#Game-shard) below.

{% api_property Game.spawns 'object&lt;string, <a href="#StructureSpawn">StructureSpawn</a>&gt;' %}

```javascript
for(const i in Game.spawns) {
    Game.spawns[i].createCreep(body);
}
```

A hash containing all your spawns with spawn names as hash keys.



{% api_property Game.structures 'object&lt;string, <a href="#Structure">Structure</a>&gt;' %}



A hash containing all your structures with structure id as hash keys.



{% api_property Game.time 'number' %}

```javascript
console.log(Game.time);
```

System game tick counter. It is automatically incremented on every tick. <a href="/game-loop.html">Learn more</a>

{% api_method Game.getObjectById 'id' 1 %}

```javascript
creep.memory.sourceId = creep.pos.findClosestByRange(FIND_SOURCES).id;
const source = Game.getObjectById(creep.memory.sourceId);
```

Get an object with the specified unique ID. It may be a game object of any type. Only objects from the rooms which are visible to you can be accessed.

{% api_method_params %}
id : string
The unique identificator.
{% endapi_method_params %}


### Return value

Returns an object instance or null if it cannot be found.

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

Send a custom message at your profile email. This way, you can set up notifications to yourself on any occasion within the game. You can schedule up to 20 notifications during one game tick. Not available in the Simulation Room.

{% api_method_params %}
message : string
Custom text which will be sent in the message. Maximum length is 1000 characters.
===
groupInterval : number
If set to 0 (default), the notification will be scheduled immediately. Otherwise, it will be grouped with other notifications and mailed out later using the specified time in minutes.
{% endapi_method_params %}
