## Advanced API Integration

We've seen how useful it can be to integrate other developers' code into our projects through the use of libraries and open-source modules. But it can also be helpful to leverage the same RESTful API pattern we saw in the Bookstore Hack-a-thon to include _data_ from third parties as well. 

There are many open APIs, but most of them are not _quite_ as open as the bookstore hack-a-thon API that we worked with earlier. While computing power is cheap, it's not _free_, and most APIs require at least a little bit of hoop-jumping to get to their data.

---

### Query Params

In a RESTful API, a resource is usually accessed by name at a unique route, e.g. `https://api.savvycoders.com/books` vs `https://api.savvycoders.com/albums`. We know that these are going to be different "things", so they get different endpoints. But what about when we want to add some extra data to our "query" of this resource? One common pattern is to use a _query param_.You can see a query param in action when you perform a Google search, for example. If you search for "Adorable Puppies", your results page probably has a URL of something like `https://google.com/?q=Adorable+Puppies` (plus some other query params with info about you). Everything after the `?` represents a bit of extra information about your search! We might implement a similar pattern to filter our `/books` in the hack-a-thon API, e.g. `/books?author=Ernest+Hemingway`. 

Let's see how `openweather.com` uses query params to protect and refine responses from their weather API.


#### Portfolio Project 1

OpenWeatherMap is a service that includes a free-to-use API that can give you information about weather conditions anywhere around the world. This is pretty powerful for developers, but the maintainers of this API need some way of making sure that users don't abuse this system or bring down the API by making too many requests at once! To manage traffic, OpenWeatherMap uses something called an _API key_. This is a unique identifier that allows `api.openweathermap.org` to restrict its responses to users with an account (which bots tend not to have) and to stop responding if users send too many requests in a short amount of time.

1. First, register for an API key at `openweathermap.org`.
2. Second, visit `https://api.openweathermap.org/data/2.5/weather` in your browser. What's the response?
3. Try again, but this time use an `APPID` query param to access the restricted endpoint (i.e. `https://api.openweathermap.org/data/2.5/weather?APPID=$YOUR_API_KEY`).
4. You should now be getting _some_ kind of response, but it's not very localized. How do we make our `weather` query more specific? Let's add a `zip` parameter and try again. You can chain together query params with an `&`, like so: `https://api.openweathermap.org/data/2.5/weather?APPID=$YOUR_API_KEY&zip=63108`
5. That's more like it! How can we store this in application state? Let's try to `dispatch` an `action` in our project's `index.js` file, like so:

```javascript
axios
  .get(/* your API endpoint from above */)
  .then(response => store.dispatch(state => assign(state, { weather: response.data })));
```
6. Now you can create a piece of state called `weather`, and you can consume that `weather` somewhere in your application! See if you can create a `Weather` component that displays the current weather somewhere on your homepage.

---

### Request Headers and Authorization

Sometimes, APIs will use query params and API keys to limit usage. More often, though, secure requests are made with the use of _request headers_. Every network request in your browser includes some extra information about that request by default. This extra information can include things like the type of content that's expected in a response, the origin of the request, and, perhaps, some type of semi-secret information about the application making a request (like an API key!). When you inspect one of these requests in a browser's dev tools, you can read any of these request headers. See if you can find the request headers that are made when your browser requests your main `index.html` file when developing locally.


#### Portfolio Project 2

The GitHub API uses an `Authorization` header to restrict access to much of its API. We can implement custom headers in our application with `axios` through a second parameter given to to `get`.Let's give it a whirl!

1. Sign up for a GitHub personal token. We'll use this token as an API key through the `Authorization` header.
2. Let's see if you can query your own GitHub account for information about your public repositories with the following syntax:

```javascript
axios
  .get('https://api.github.com/users/$YOUR_GITHUB_USERNAME/repos', {
    'headers': {
      'Authorization': `token ${$YOUR_API_KEY}`
    }
  })
  .then(/* handle the response */);
```
3. But how, exactly, are we supposed to `handle the response`? By `dispatch`-ing a reducer function that applies this new data to state, e.g.:
```javascript
axios
  .get('https://api.github.com/users/$YOUR_GITHUB_USERNAME/repos', {
    'headers': {
      'Authorization': `token ${$YOUR_API_KEY}`
    }
  })
  .then(response => store.dispatch(state => assign(state, { repos: response.data })));
```
4. BONUS: can you render that data with a `Repo` component? Where do you need to include that new piece of state?
