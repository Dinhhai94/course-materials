## Async and APIs

### Working with Time

You've come a long way from your very first bits of code! As you've progressed, you've learned to think and develop with increasing levels of abstraction, all while responding to more and more interaction from your users. Let's take a look back through your journey so far:

1. First, we had plain-text content.
2. Next, we added additional attributes and information to that content through HTML and CSS.
3. Then we created our first transient statements of action vs content (e.g. `2 + 2`).
4. Then we started adding these action statements to our static content (e.g. `const greeting = function(){ alert( "hello!" ) };`).
5. Then we started dealing with the idea of responding to user state using an _imperative_ style of programming (e.g. `if` and `else` statements), but our program would only be run once per page load. These weren't applications as much as "scripts".
6. Then we finally built our first truly interactive application once we got to _event-driven_ programming. Now we can respond to custom inputs from users, whenever those inputs happen!

One of the hallmarks of an interactive application is that we, as developers, have a much more fluid interaction with time than we do in steps 1 through 5. Events can happen at any time, in any order, and it's up to us to "listen" to and "handle" any event whenever they end up happening. Up to this point, though, we've been operating under the assumption that the only "delays" that might occur came from users, rather than from within our own application processes. But what happens when we aren't sure how long it'll take for our code to execute? Think about the following:

```javascript
function randomFinish(label) {
  const randomTime = Math.random() * 1000;

  setTimeout(() => console.log(label + "is done!"), randomTime);
}

randomFinish("function 1");
randomFinish("function 2");
randomFinish("function 3");
```

There's no guarantee that the `function`s would finish in order! How could we handle a situation where we always wanted `function 1` to fire before `function 2` before `function 3`, even when we don't know how long it will take for each function to finish?

---

#### The Recursive Solution

We could use recursion to make sure that `randomFinish` always called the next iteration in order, like so:

```javascript
function handleFinish(count) {
    const label = `function ${count}`;

    console.log(`${label} is done!`);

    if( count < 3 ){
        randomFinish( count + 1 );
    }
};

function randomFinish(count) {
    const randomTime = Math.random() * 1000;

    setTimeout(
        () => handleFinish( count ),
        randomTime
    );
};

randomFinish( 1 );
```

While the above _works_, it's not a great solution for a couple of reasons. First, the handling of our function happens within the function itself, which is probably no good. What happens when the spec for these functions changes? What if other functions _also_ depend on `randomFinish`... will those functions be added to `handleFinish` as well?

Hopefully you can see why this would be bad long-term design, even if our solution technically works.

---

### Promises

In some async cases, it may be better to use a special kind of Object called a `Promise`. Promises are like IOUs: you can create an IOU, specify how you'd like to handle whatever comes back from the IOU, and then the IOU can resolve in some way later on (either, "here's what you're owed" or "sorry, you get nothing"... just like a real IOU).

Promises are created with the `new` keyword, and is given a callback function that is passed two parameters: a `resolve` function and a `reject` function, which handle the two possible outcomes of a `Promise`. These two options can then be handled using the `.then` or `.catch` methods of the newly-constructed Promise.

That's a lot to take in, so let's see what our example above might look like with Promises:

```javascript
function handleFinish(count, resolve) {
  const label = `function ${count}`;

  console.log(`${label} is done!`);

  resolve(count + 1);
  // resolves the Promise that was constructed in randomFinish,
  // to be handled with .then()
}

function randomFinish(count) {
  const randomTime = Math.random() * 1000;

  return new Promise(resolve => { // the Promise constructor takes one argument: the function below
    // resolve is a function, too! reject is unused in this example
    setTimeout(() => handleFinish(count, resolve), randomTime);
  });
}

randomFinish(1)
  .then(randomFinish)
  .then(randomFinish);
```

Wow! Check out that final syntax... by returning `Promises`, each iteration of `randomFinish` can be chained together using the `.then` method. Not only is that clear and easy to read, but the important functions are all grouped together to make the whole application's flow easier to understand.

---

### AJAX

So this is neat, but when do we use this "in the real world"? Sure, there are some UI interactions that might require a `setTimeout`-driven delay, but those are rare. Instead, the `Promise` structure and syntax are used primarily for those functions that are meant to fetch data asynchronously. Namely, Asynchronous JavaScript And XML, or AJAX! This is how most JS applications interact with data, pulling information from Application/Programmer Interfaces (APIs) that can be handled by JavaScript.

---

### RESTful JSON APIs

The most common type of API you'll interact with as a web developer is a RESTful (standing for REsponsive State Transfer) JSON (JavaScript Object Notation) API. This kind of API leverages the HTTP verbs that we've seen before in our work with forms (e.g. `GET`, `POST`, etc.), but uses a JavaScript-compatible data format instead of URL-encoded data. To make more sense of this idea, let's take a look at an example API that's set up for us to make AJAX requests.

1. Navigate to [https://jsonplaceholder.typicode.com/](https://jsonplaceholder.typicode.com/) and take a look at the documentation on that page.
2. Now to go [https://jsonplaceholder.typicode.com/posts](https://jsonplaceholder.typicode.com/posts). What comes back?
3. Instead of returning HTML, this URL returns plain text formatted according to JavaScript standards. This kind of URL is called a "route" or an "endpoint", and it's returning data in JSON ("JavaScript Object Notation") format. What are the data types you see here?
4. Notice the URL `/posts`. What happens when you go to [https://jsonplaceholder.typicode.com/posts/1](https://jsonplaceholder.typicode.com/posts/1)? Why do you think these routes are set up like this?

---

### `fetch` and `axios`

If we're going to use data from an API like this one, we have to accept that there are going to be some delays and uncertainties regarding the acquisition of this data. There will be time spent sending the request, time spent retrieving the information, time spent parsing the information, and the possibility of failure throughout the entire operation.

We _could_ use native JavaScript' `XMLHttpResponse` method to retrieve this data, but that method is sometimes tricky to handle properly... most of the time, the response is handled imperatively, even if the data comes back asynchronously. Wouldn't it be nice if we could use `Promise`s instead?

Luckily, most browsers have implemented at least a part of the new [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API) for retrieving data asynchronously using Promises. Let's try it out with JSON placeholder!

### Exercise 1

#### Fetching data with `fetch`

1. Try the following anywhere in your developer console:

```javascript
fetch("https://jsonplaceholder.typicode.com/posts")
  .then(response => response.json())
  .then(json => console.log(json));
```

2. You should have noticed a slight delay before the data was output to your console as a fully-parsed JavaScript Object. That's pretty neat! Now see if you can repeat that process for some of the other JSON placeholder resources.

---

`fetch` works quite well for very basic `GET` requests, but it can be tough to work with for more complex AJAX operations. There are also slight deviations between browser implementations, which can lead to some frustrating and hard-to-track-down bugs in the future. Luckily, we have third-party libraries to help us out!

### Exercise 2

#### Fetching data with `axios`

The library that we'll use for the remainder of the course is called [axios](https://github.com/axios/axios). It's like `fetch`, but works in _and_ out of the browser, has a number of more sensible defaults that are missing from `fetch`, and is just a bit more convenient for those complex requests. Let's try using `axios` to fetch some blog posts for our `Blog` page!

1. `axios` is a third-party library, so we'll need to include it as a dependency through `npm`:

```
npm install --save axios
```

2. Let's re-write the first part of Exercise 1 with `axios`. You'll notice that it looks pretty similar, but doesn't require `fetch`'s unwrapping/JSON parsing step:

```javascript
axios
  .get("https://jsonplaceholder.typicode.com/posts")
  .then(response => console.log(response.posts));
```

3. That was easy! But now how do we use this data in our application? You'll recall that we've set up our entire application as a single relationship between our application `state` and the way that application is presented. So using this new data is as simple as augmenting our `state` and re-rendering the app. That will look something like this:

```javascript
import * as states from "./store";

state.posts = []; // initializes empty piece of state

axios
  .get("https://jsonplaceholder.typicode.com/posts")
  .then(response => response.data.forEach(post => state.posts.push(post)));
```

The code above defines a piece of our `state` Object just for our posts. If the `Blog` page is the first thing to be rendered, there won't be any errors on initial page load, and there will be a slight delay while all of the posts are fetched.

4. The next thing is to re-render the application with the updated state! You'll recall that the router is handling most of our application rendering, so let's leverage that route handling to re-render the application once we've received some data from this external API:

```javascript
axios.get("https://jsonplaceholder.typicode.com/posts").then(response => {
  const params = router.lastRouteResolved().params;

  response.data.forEach(post => state.posts.push(post));

  if (params) {
    // required for the home page
    handleRoute(params);
  }
});
```

This uses `lastRouteResolved` to query the router for the last route that's been handled (which is the same thing as "the current page" from the user's perspective), then sends those `params` down the pipeline to route handler after the `state` has been augmented with our new `post` data.

5. Now our `startApp` function is being called at the correct time, but what about our stateless functional components? How can we use our existing components to parse this new piece of the `state` tree? Don't forget that it's components all the way down! Let's see what happens when we turn the `body` components that we made earlier into a functional component that can handle `state` as well. Our `Content` component becomes:

```javascript
import * as pages from "./Pages";

export default function Content(state) {
  return `
    <div>
      ${pages[state.body](state)} // pass that state!
    </div>
  `;
}
```

You should see some `Blog is not a function` errors until we change the `Blog` component into a stateless functional component, e.g.:

```javascript
export default function Blog(state) {
  return state
    .posts
    .??? // what to do here?
}
```

6. But what to do with these `posts` now? What we really want to do is _transform_ these post Objects into a single post String, right? To do that, let's create another function that we can use to generate individual posts. Something like:

```javascript
function mapPost(post) {
  return `
    <div>
      <h3>${post.title}</h3>
      <p>${post.body}</p>
    </div>
  `;
}
```

Notice how any function that generates new markup follows a similar pattern: `state` (or a piece of `state`) in, HTML (as a JavaScript String) out.

7. To bring it all together, our new `Blog` function becomes:

```javascript
function mapPost(post) {
  return `
    <div>
      <h3>${post.title}</h3>
      <p>${post.body}</p>
    </div>
  `;
}

export default function Blog(state) {
  return state.posts.map(mapPost).join(""); // this condenses an Array into a String
}
```

Now we see how to render subcomponents through the entire component tree _and_ we see how to do it with asynchronous data. This is a big part of being a web developer, and you should feel accomplished for getting to this point!
