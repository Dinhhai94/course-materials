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

1. To start, let's create a directory called `store` that will contain all of our `state`s. Inside that `store` directory, create a single `index.js` file. This file will act similarly to the way the `index.html` does for HTML documents: our bundler will, by default, look for that `index` if no explicit file path is provided.
2.  Inside of `store`, let's create a separate JavaScript file for each part of our state tree, That means new `Home`, `Blog`, `Contact`, and `Projects` files. Each of these files should have a single `default` export of a single Object. That Object should represent that single piece of the original state tree. So, for example, the `Blog` module would look like this:

```javascript
export default {
  'links': [
      'Home',
      'Contact',
      'Projects'
  ],
  'title': 'Welcome to my Blog'
};
```
3. Once every state module has been created, we can re-export each of those modules with a name in `store/index.js`. The syntax for one of those re-exports would be `export { default as SomeName } from './some-location';`. See if you can re-export all of these pieces of our state tree with this syntax! HINT:

```javascript
export { default as Blog } from './Blog';
export { default as Contact } from './Contact';
export { default as Home } from './Home';
export { default as Projects } from './Projects';
```
4. Now that this base module has been set up we should be able to `import` our states through the module system. In this case, we would like to `import` _all_ of the states in one big glob using the `* as name` syntax. Try the following in your root-level `index.js` file, and see if you can figure out what the data type of `states` will be:

```javascript
import * as states from './store';

console.log(states); // what's the data type here?
```
5. We should now be able to access any piece of our `states` tree, just as before! Except that this time, all of the complexity of our application state is hidden away behind our module system (which is a _good_ thing). 
6. Now that we've ironed out navigation, let's see if we can finally get our _content_ to change in response to our user input! You should still have HTML files that represent content for your `Blog`, `Content`, and `Projects` landing pages that we haven't yet incorporated into our new Single-Page architecture. Let's convert those pieces of HTML into their own `component`s. To start, let's create a `Pages` directory inside our `components` directory. This is a common pattern when dealing with a group of similar components. In this case, we're grouping all of the different page-level (or content-level) templates.
7. Let's repeat the export pattern from our `states`. That means creating an `index.js` file next to a `Blog.js`, `Contact.js`, `Home.js`, and `Projects.js` file inside of `components/Pages`. Each Page component should `export` some HTML as a template literal, e.g.:

```javascript
export default `
  <form>
    <input type="text" name="test">
    <input type="submit">
  </form>
`;
```
...and re-`export` those `default`s with a name from `components/Pages/index.js`, e.g.:

```
export { default as Contact } from './Contact';
```
8. Now each `state` component can import a template directly from the `components/Pages` directory. Let's attach that content to each state component as a `body` property. For example, our `Blog` state might become:

```javascript
import { Blog } from '../components/Pages';

export default {
    'body': Blog,
    'links': [
        'Home',
        'Contact',
        'Projects'
    ],
    'title': 'Welcome to my Blog'
};
```
Notice the single non-`default` `import` of the `Blog` component.
9. Once you've associated some content with each piece of the state tree, it's time to change our `Content` component to allow for variation in the `body` property of a `state` parameter. That means our `Content` component becomes:

```javascript
export default function Content(state){
    return `
        <div id="content">
            ${state.body}
        </div>
    `;
};
```

Now you should have a Single-Page application that behaves almost exactly like our old HTML page-based site, but with a lot more flexibility and some real performance wins for our users.
