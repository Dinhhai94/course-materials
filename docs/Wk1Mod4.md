## Forms and Positioning

### HTML `form` elements and intermediate CSS

HTML forms are used to collect user input. The `<form>` element defines an HTML form. Form elements are different types of `input` elements, checkboxes, radio buttons, submit buttons, and more.

---

### Portfolio Project 1

Let's create a new contact page for your website!

1. Use the same method we've used for our `projects` and `blog` pages to create a `contact` page. When you're finished, your site's directory structure should look like this:

```
/ (root)
|
|-blog/
|   |-index.html
|
|-contact/
|   |-index.html
|
|-css/
|   |-style.css
|
|-projects/
|   |-index.html
|
|-index.html
|-.git (hidden directory)
```

2. Set up your new contact page to use the same stylesheet as the rest of your site. HINT:

```html
<link type="text/css" rel="stylesheet" href="../css/style.css"/>
```

3. Now set up the rest of your page's structure, including a navigation bar, `.container` area, and footer (like the other pages in your portfolio site).

---

### Portfolio Project 2

The heart of your contact page will almost certainly be a form. Let's try out a very basic form to get started:

1. Type out the following code in the content area of your contact page:

```html
<form>
  <input type="text">
  <input type="password">
  <input type="email">
  <input type="submit">
</form>
```

2. Try working with each element to see what it does in a browser preview.
3. Once everything is up-and-running, stage, commit, push, and deploy your website!
4. Now let's try a more complicated example. Replace the code from above with the following snippet. Try to re-type instead of copy->pasting!

```html
  <!--
  The action attribute defines where on the server the form data should be sent
  The method attribute specifies the HTTP method (GET or POST)
-->

<form action="form-responses/new" method="POST">

  <input type="text" name="firstname" value="First Name" size="100" autofocus>
  <input type="text" name="lastname" value="Last Name" size="100">
  <input type="email" name="userEmail" placeholder="your.email@example.com">

  <label>What's this message about?
    <input type="radio" name="subject" value="professional" checked><span>I'd like to hire you!</span>
    <input type="radio" name="subject" value="personal" checked><span>Personal message</span>
    <input type="radio" name="subject" value="other" checked><span>Don't know/something else</span>
  </label>

  <input type="checkbox" name="optin" value="trusting" checked>Subscribe me to your newsletter!
  <input type="checkbox" name="optout" value="skeptical" disabled>Cheeky checkbox...

  <label for="marketing">How did you hear about me?</label>
  <select name="marketing">
    <optgroup label="Online">
      <option value="social">Social Media (FB, Twitter, LinkedIn)</option>
      <option value="github">Online Portfolio (GitHub)</option>
      <option value="search">Search Engine</option>
      <option value="email">Email</option>
    </optgroup>
    <optgroup label="In-Person">
      <option value="networking">We met at a networking event</option>
      <option value="referral">Personal referral</option>
      <option value="random">We met somewhere else</option>
    </optgroup>
    <option value="other">Other</option>
  </select>

  <textarea name="user_message" rows="8" cols="40"></textarea>
  <input type="submit">
</form>
```

Spend a little bit of time breaking and fixing the form above. Also try submitting the form... what happens?

5. Style the form a bit!

- add `<br>` elements to separate inputs onto new lines
- add some `<labels>` with either the wrapping syntax or the `for` attribute.
- select individual inputs with the syntax `input[type="SPECIFIC TYPE HERE"]`. Types include `checkbox`, `radio`, and `text`.
- try changing the `width`, `height`, `padding`, and `margins` of each element to make the form more read-able

---

### Network Traffic

When you submitted the form data, why was there an error in the console?
![network error](http://reactorprep.herokuapp.com/assets/images/network_tab.png)

The `action` attribute tries to `POST` data to a server somewhere, but there's no server specified, so things go haywire.This request-response cycle is the foundation of the internet! We're not going to mess with it very much, though. Instead, we'll use a service called [Formspree](http://formspree.io/) to act as a server for our contact form data.

![the internet!](http://reactorprep.herokuapp.com/assets/images/get_request.png)

---

### HTML5 Form Elements

HTML5 gives us fancy new input types. Give them all a try by setting the type attribute of an input element to the following:

- color
- date
- datetime
- datetime-local
- file
- email
- month
- number
- range
- search
- tel
- time
- url
- week

We can also use HTML attributes to change the behavior of form elements or do form validation to only allow users to submit the form when certain conditions are met. Try out a few:

- disabled -- Specifies that an input field should be disabled
- max -- Specifies the maximum value for an input field
- maxlength -- Specifies the maximum number of character for an input field
- min -- Specifies the minimum value for an input field
- pattern -- Specifies a regular expression to check the input value against
- readonly -- Specifies that an input field is read only (cannot be changed)
- required -- Specifies that an input field is required (must be filled out)
- value -- Specifies the default value for an input field

---

### Portfolio Project 3

Let's add some form validation to your contact form.

1. Mark all required fields with `required`.
2. Anything that isn't required should have a default `value`.
3. While not exactly form validation, it's very helpful to have a `placeholder` value for text inputs.
4. It can also be useful to check some boxes by default with `checked`.
5. Change your opening `<form>` tag to implement [Formspree](http://formspree.io/), like so:

```html
<form action="//formspree.io/your.email@example.com" method="POST">
```

6. Once your new-and-improved form works like you would like, stage, commit, push and deploy your site.
7. When your site is live, test out your form! You should get parsed responses from Formspree as soon as you confirm your email address.

---

## Specificity

Up to this point, you've heard all about the 'cascade' in _Cascading Style Sheets_. That cascade refers to the way in which styles are applied in a cascading pattern of increasing [**specificity**](https://css-tricks.com/specifics-on-css-specificity/). Up to this point, you've heard the term "specificity" used colloquially, but here we're going to give you a quick way of putting a number value on a given selector's specificity.

![specificity diagram](https://css-tricks.com/wp-content/csstricks-uploads/specificity-calculationbase.png)

As a quick rule of thumb, look at a selector, and put a number in the correct box that corresponds to the number of each selector's component parts. As an example:

![example specificity calculation](https://css-tricks.com/wp-content/csstricks-uploads/cssspecificity-calc-1.png)

![example specificity calculation 2](https://css-tricks.com/wp-content/csstricks-uploads/cssspecificity-calc-2.png)

In this example, there are more component parts in the second example, but the first is still more specific (and would take precendent over the second in the event of a rule collision) because of the power of the ID `#nav`

---

## CSS Layouts and Positioning

Up until this point, we've worked only with single-column HTML documents. What if we want more complex layouts. Maybe a snazzy sidebar, like this? And what about a drop-down menus in the navigation bar?

![2-column layout](http://reactorprep.herokuapp.com/assets/images/2-column-layout.jpg)

The layout above is a very common layout for blogs... much like the blog that we've made for our Portfolio Project. In this module, we'll handle basic top-to-bottom positioning, and we'll introduce the grid system in the next module to handle the sidebar!

---

### Portfolio Project 4

1. Your blog page shouldn't have much of a layout at the moment. At the very least, though, you should have the following:

- A navigation 'bar' (that's really a list)
- A header area with your blog's title and intro text
- A content area with some basic styles
- A footer with extra content (like copyright and contact info)
- A `.container` div that wraps all the useful/visible content. The style for `.container` should be contained in your `style.css` stylesheet. HINT:

  ```css
  .container {
    max-width: 960px;
    margin: 0 auto;
  }
  ```

2. Let's change the unordered list (`<ul>`) of navigation links into an actual horizontal bar instead of a vertical bullet-pointed list. Try the following in your navigation bar (with a `class` of `navigation`, for this example):

```css
#navigation > ul > li {
  display: inline;
  list-style: none;
}
```

3. Now let's make our navigation bar 'sticky' by **fixing** its **position** in the viewport. Try the following CSS:

```css
#navigation {
  position: fixed;
  top: 0;
  left: 0;
}
```

4. Add a `margin-top` value to next page element to keep navigation from overlapping useful content. If the next section has a `class` of `header`, your CSS might look like this up to this point:

```css
#navigation {
  position: fixed;
  top: 0;
  left: 0;
  height: 1.3em;
  width: 100vw;
}

#navigation > ul > li {
  display: inline;
  list-style: none;
}

.header {
  margin-top: 1.3em;
}
```

5. So how to add that dropdown menu? Let's start with the markup. First, imaginine a top-level navigation bar item called `projects`. We'll want to organize our markdown such that the dropdown menu is nested inside the `<li>` that displays the `projects` label. We'll also give the dropdown `<ul>` a class of `dropdown` for good measure.

```html
<li>
  <a href="/projects">Projects</a>
  <ul class="dropdown">
    <li><a href="#">First Project</a></li>
    <li><a href="#">Second Project</a></li>
    <li><a href="#">Third Project</a></li>
  </ul>
</li>
```

6. There are two issues with this `dropdown` as-written: first, the dropdown is always visible. Second, the dropdown is affecting the height of the navigation bar, when we'd rather have the dropdown "float" over the rest of the content in the header. Let's tackle the first issue with `display` and `:hover`:

```css
#navigation .dropdown {
  display: none; // this hides the dropdown menu by default
}

#navigation a:hover + .dropdown {
  display: block; // shows the any dropdown that is a direct sibling of a hovered anchor tag in the navigation bar
}
```

7. But how to tackle the page flow issue? We can't use `position: fixed`, because we don't always know where this dropdown's associated `projects` link is going to be relative to the viewport. Instead, we'll use `position: absolute` in combination with `position: relative` to make sure that our dropdown menu "tracks" its parent.

```css
#navigation > ul > li {
  position: relative; // required for absolute positioning
  display: inline;
  list-style: none;
}

#navigation .dropdown {
  position: absolute; // tracks nearest relatively-positioned ancestor
  top: 1em; // positions according to the ancestor
  right: 0;
  display: none;
}

#navigation a:hover + .dropdown {
  display: block;
}
```

7. Now it's time to fix our navigation menu to be a bit more responsive! To do that, we're going to use a newer CSS property called **flex-box**. Flex-box helps us align, justify, and wrap content within a container of variable width. Let's see if we can create a navigation menu that wraps automatically on smaller screens!
1. Change your `#navigation` CSS to the following:

```css
#navigation {
  position: fixed;
  top: 0;
  left: 0;
  height: auto;
  width: 100vw;
}
```

2. If you haven't already, give the `<ul>` in your `#navigation` section a class of `.container` to center the useful links on a large screen. We also need to add some CSS to our `ul.container` element. CSS for the whole `#navigation` family is going to look like this:

```css
#navigation {
  position: fixed;
  top: 0;
  left: 0;
  height: auto;
  width: 100vw;
}

#navigation > ul > li {
  position: relative;
  display: inline;
  list-style: none;
}

#navigation .dropdown {
  position: absolute;
  top: 1em;
  right: 0;
  display: none;
}

#navigation a:hover + .dropdown {
  display: block;
}

#navigation > ul.container {
  //these styles will extend the styles already contained in the .container class
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: space-around;
  align-items: center;
}
```

Flex-Box works with the same parent-child relationship that we saw with `position: relative` and `position: absolute`. In this case, we're setting up `ul.container` as our parent element, and each `li` element inside as the children. The CSS rules added to `ul.container` have the following properties:

- `display: flex` sets up the parent element (much like `position: relative` did)
- `flex-direction` tells the flex-box which way to 'flex': `row` for horizontally, `column` for vertically
- `flex-wrap` tells the flex-box what to do with children when they've reached the edge of the parent. In this case, we're using `wrap` to wrap list elements around into a new row.
- `justify-content` defines the spacing of child elements. They can be evenly spaced from the edges with `spac-around`, maximize space between elements with `space-between`, or be clumped at the start, end, or center of the parent element with `flex-start`, `flex-end`, or `center`, respectively.
- `align-items` defines how children should be aligned with one another on the axis perpendicular to the `flex-direction`. In this case, `center` vertically aligns all `li` elements. If `flex-direction` were `column`, `center` would align items horizontally.

8. And there you have it... a (mostly) responsive layout built with CSS! At this point, you can add any padding or margins you need to get your page looking pretty, then stage, commit, push, and deploy your changes.

---

Congrats on your fancy new blog! As extra credit: implement a responsive layout for all of your pages. Share your pages on Slack as you add features and styles, and get excited for next class's work with _grids_ and a class Hack-A-Thon!
