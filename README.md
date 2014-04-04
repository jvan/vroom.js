vroom.js is an experimental webgl port of vroom. 

Applications are written in javascript and can be viewed in any webgl-capable
browser (you can check if your current browser supports webgl
[here][webgl-check]).

[webgl-check]: http://doesmybrowsersupportwebgl.com


## Installation

vroom.js requires [node][node]. You can download an installer for
your system [here][node-download].

After installing node on your system, install coffeescript, grunt, and
additional dependencies.

```shell
sudo npm install -g coffee-script
sudo npm install -g grunt-cli
npm install
```

Once the necessary packages are installed, build the vroom.js library.

```shell
grunt
```

[node]: http://nodejs.org
[node-download]: http://nodejs.org/download/


## Getting Started

Start the vroom.js server.

```shell
vroom-server.js
```

You can see a list of example programs by opening
[localhost:3000/examples/](localhost:3000/examples/) in your web browser.

Applications are located in the `public/apps/` directory.  To enable
live-coding, provide the path to the source file (relative to the `public/`
directory) when starting the server. For example, to run the application
`public/apps/simple.js` execute the following command.

```shell
vroom-server.js apps/simple.js
```

The application can then be viewed at [localhost:3000/](localhost:3000/). When
changes are made to the source code the application will update automatically. 
