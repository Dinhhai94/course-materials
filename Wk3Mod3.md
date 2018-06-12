## Third-Party Dependencies
### Advanced modules and library usage

One of the wonderful things about the modern JavaScript ecosystem is that there are literally _thousands_ of libraries for us to use, solving any number of complex problems we might encounter in the realm of web development. Learning how to install, manage, and `import` these third-party dependencies is a key part of being an effective web developer.

### More Modules

You'll recall that we've been working with our own library of components through by `import`-ing and `export`-ing `default` chunks of JavaScript. But there are a few variations on this these syntaxes that will help us keep our code organized as our applications begin to pull in third-party dependencies. Here's a quick overview:

```javascript
// import the default export from a module
import toolbox from 'toolbox';

// import a single export (of many) from a module
import { tool } from 'toolbox'; 

// import many exports at once from a module
import * from 'toolbox';

// import many exports as a named Object from a module
import * as tools from 'toolbox';

// export a single, default chunk from a module
export default 'toolbox';

// export a single chunk (of many) from a module
export 'tool';
```

Let's see how these `import`/`export` variations might help us organize our large state and content trees in our portfolio projects.

### Portfolio Project 1
#### Modular State and Content

When last we left our state tree, it was beginning to look something like this:

```javascript
var states = {
    'Home': {
        'links': [
            'Blog',
            'Contact',
            'Projects'
        ],
        'title': 'Welcome to my Portfolio'
    },
    'Blog': {
        'links': [
            'Home',
            'Contact',
            'Projects'
        ],
        'title': 'Welcome to my Blog'
    },
    'Contact': {
        'links': [
            'Home',
            'Blog',
            'Projects'
        ],
        'title': 'Contact Me'
    },
    'Projects': {
        'links': [
            'Home',
            'Blog',
            'Contact',
            'Choose-Your-Own-Adventure',
            'Rock-Paper-Scissors'
        ],
        'title': 'Check out some of my projects'
    }
};
```

This is pretty ungainly. Let's see if we can clean this up by extracting all of these disparate states into their own modules.
