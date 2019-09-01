# CSS and larger documents

## Styling and Larger Web Documents

### Inline Styles

There are three ways to give HTML content some styles:

* inline styles \(the `style` attribute\)
* style tags \(`<style>` in document `<head>`\)
* stylesheets \(external documents linked with `<link>`\)

Today, we're going to take a look at inline styles. Inline styles are generally avoided in production websites, but you'll still see them in the wild in old codebases or in some niche applications \(like MailChimp templates\). To get a feel for inline styles, take a look at the following code:

```markup
  <body style="background-color:lightgrey;">
    <h1 style="color:blue;">This is a heading</h1>
    <h1 style="color:#AA22FF;">Also a heading</h1>
    <h1 style="color:rgb(0,255,255);">Moar!!</h1>
    <p style="color:red; background-color:green;">This is a paragraph.</p>
    <img src="https://i.imgur.com/81qyN1y.jpg" style="height:100px; width:100px;">
  </body>
```

Try writing it out in a new HTML document in your `exercises` directory, then previewing the result in your browser.

So what have we learned?

1. The value of the HTML attribute named style styles HTML elements
2. The styles are described using a language called CSS. Here are the rules of CSS:
3. CSS rules are key-value pairs \(similar to HTML attributes\)
4. The key represent the property to be changed \(like 'color' or 'background-color'\)
5. The value represents what it should be changed to \('blue' or 'red'\)
6. The key and value are separated by a colon
7. Each key-value pair is separated with a semi-colon
8. Colors can be described by name, as eight digit hex \(base 16\) values between 0 \(black\) and F \(white\), or as Red Green Blue triplets from 0 to 255
9. We can use the following css colors for our background-color and color attributes:

   ![css color table](http://reactorprep.herokuapp.com/assets/images/css_colors.jpg)

#### Portfolio Project 3

Let's create a theme for your Portfolio Project's landing page.

1. Use the following attributes somewhere on the page:
2. `background-color`
3. `color`
4. `width`
5. `height`
6. Make sure that all styles are inlined with the syntax `style=" "`
7. Stage and commit your changes using `git`.
8. Push your committed changes to your GitHub account.

Let's try out a few more styles. We won't get to every CSS property today \(or in this course\), but you can always find an exhaustive and up-to-date list of every property at [this address](https://developer.mozilla.org/en-US/docs/Web/CSS/Reference) Try out the following HTML in your browser:

```markup
<h1 style="font-family:verdana;color:orange;">This is a heading</h1>
<p style="color:green;">This <i style="color:orange;font-size:300%">is</i> a paragraph.</p>
<p style="color:green;">This <i style="font-size:300%;">is</i> a paragraph.</p>
<p style="color:green;font-size:40px;text-align:center;font-family:'Times New Roman';">This is a paragraph.</p>
```

What did we learn?

1. Styles applied to parent elements effect their children \(nested\) elements, unless that style is overwritten.
2. We can put a lot of styles on a single HTML element, but it gets messy.
3. We can apply the same style to every tag of a particular type \(all paragraphs should be green\), but we have to reapply it on each element.

The last two points are reasons why inlining styles is generally frowned upon. So how do we solve that problem?

### The `<style>` tag

So let's begin to refactor the mess above. CSS rules can be applied to an HTML page by placing them inside a `<style>` element inside the `<head>` element of the page.

We begin with a selector to indicate which elements the rules apply to. Then, inside of curly braces, we indicate how the elements should be styled. Declarations are split into two parts \(a property and a value\), are separated by a colon, and end with a semicolon, like so:

```markup
<html>
  <head>
    <style>
      h1 {
        font-family: verdana;
      }
      p {
        color: green;
      }
      i {
        font-size: 300%;
      }
    </style>
  </head>
  <body>
    <h1 style="color:orange;">This is a heading</h1>
    <p>This <i style="color:orange;">is</i> a paragraph.</p>
    <p>This <i>is</i> a paragraph.</p>
    <p style="font-size:300%; text-align:center; font-family:'Times New Roman';">This is by far the most important part of the page!</p>
  </body>
</html>
```

Ok, so far, so good. We have styles common to tags of the same type as shared styles. How can we represent all the extra styling on that last `<p>` tag?

Every HTML element can carry an `id` attribute to uniquely identify it. No two elements on the same page may have the same value for their `id` attributes. The css selector to match for an `id` starts with a hash \(`#`\).

Here's how we might apply extra styling to the important `<p>` tag in this example:

```markup
<html>
  <head>
    <style>
      h1 {
        font-family: verdana;
      }
      p {
        color: green;
      }
      i {
        font-size: 300%;
      }
      #primary {
        font-size: 300%;
        text-align: center;
        font-family: 'Times New Roman';
      }
    </style>
  </head>
  <body>
    <h1 style="color:orange;">This is a heading</h1>
    <p>This <i style="color:orange;">is</i> a paragraph.</p>
    <p>This <i>is</i> a paragraph.</p>
    <p id="primary">This is by far the most important part of the page!</p>
  </body>
</html>
```

Okay, now what about the two oranged elements?

Every HTML element can also carry one or more `class` names in a `class` attribute to identify several elements as being different from the other elements on the page. The css selector to match for a class starts with a period \(`.`\). Here's how we might add a class to our example:

```markup
<html>
  <head>
    <style>
      h1 {
        font-family: verdana;
      }
      p {
        color: green;
      }
      .big {
        font-size: 300%;
      }
      #primary {
        text-align: center;
        font-family: 'Times New Roman';
      }
      .important {
        color: orange;
      }
    </style>
  </head>
  <body>
    <h1 class="important">This is a heading</h1>
    <p>This <i class="important big">is</i> a paragraph.</p>
    <p>This <i class="big">is</i> a paragraph.</p>
    <p id="primary" class="big">This is by far the most important part of the page!</p>
  </body>
<html>
```

Elements can have more than one class, but should only ever have a single id. Why is that?

Now we have separated **presentation** from **content**. We can easily read the content of our HTML document without it being cluttered up with styles. By sharing styles we also save ourselves a lot of typing as we create larger and larger HTML documents.

#### Portfolio Project 4

**You will be judged** by professional developers for placing styles directly on HTML elements. Let's fix your Portfolio Project to reflect proper CSS design patterns:

1. Purge your landing page's HTML elements of `style=" "` attributes. Move all styling to a `<style>` tag in the `<head>`
2. Look for \(or change your code to create\) opportunities to use `id` and `class` attributes.
3. Stage, commit, push, and deploy your new Portfolio Site

## Stylesheets

While the `<style>` tag works for individual pages, it doesn't work well for scaling styles. Instead, it's better for each page to reference a single **stylesheet**, containing all of the CSS rules for the page. By keeping all of your CSS rules in an external document, you'll find that it's easier to make changes across a website, maintain separate roles on a dev team, and save yourself from early-onset carpal tunnel because of re-typing.

Let's create a stylesheet for our Portfolio Project that applies to all of our pages!

1. First, we need to create a separate file with the `.css` file extension. Let's go ahead and call it `style.css`. To keep things organized, let's create that file inside its own `css` directory \(since we might want to add multiple stylesheets to the same document\). HINT:

   ```text
   $ mkdir css
   $ touch style.css
   ```

2. Next, we need to `link` that stylesheet to each of our pages. In the `<head>` of each page, add the following:

   ```markup
   <!-- for your landing page -->
   <link rel="stylesheet" href="css/style.css">

   <!-- for all other pages -->
   <link rel="stylesheet" href="../css/style.css">
   ```

   _Do you know why we need different `href` values for our landing page and our projects and blog pages?_

3. At this point, there shouldn't be any difference in the way your pages look or behave, since there's nothing in `style.css`. For now, you should stage, commit, push, and deploy your page to make sure that everything looks the same in the browser.
4. Now we need to refactor all of the styles across pages. Copy all of the styles from each page into `style.css` page-by-page, starting with your blog page. Make sure you get each page looking like you'd like it. Remember that all CSS properties from here on out are shared between pages! If you need to make changes to your HTML to better organize your styles, that's OK, too.
5. Once every page is looking good, stage, commit, push, and deploy your changes. And congrats on your pretty new Portfolio site!

### `div`, CSS selectors, stylesheets, and specificity

Now that we have our styling in order, let's think about how to build larger web pages in an orderly way...

```markup
<div id="greeting" class="section">
  <h1>Hello!</h1>
  <p>This content is all related!</p>
  <p>Nice that we can group it using a "div" tag!</p>
</div>
```

The `<div>` element is a generic block element which defines a section of your page. Unlike block elements with specific meaning and implied default styling \(like `<h1>` and `<p>` tags\), `<div>` elements don't change the appearance of the page until styles are applied to them.

```markup
<p>Sometimes, <span class="highlight">all we really want</span> is
to be able to refer to certain sections of our page, but we want to completely
<span class="highlight">control their styling</span>, and not get the
"b" or "i" tags involved</p>
```

The `<span>` element is a generic inline element which defines a section of your page. Unlike inline elements with specific meaning and implied default styling \(like `<b>` and `<i>` tags\), `<span>` elements don't change the appearance of the page until styles are applied to them.

### Portfolio Project 1

Let's add another page to our growing Portfolio Project! This page will be for your future personal blog.

1. Repeat the same steps we went through to build the `projects` page. We'll call the blog page `blog` \(makes sense, right?\). Once you've finished creating the blog page, your site's directory structure should look this:

   ```text
    / (root)
    |
    |-/blog
    |   |-index.html
    |
    |-/projects
    |   |-index.html
    |
    |-index.html
    |-.git (hidden directory)
   ```

2. Inside of your new `blog/index.html` file, create a short blog post welcoming readers to your blog \(no more than 5 sentences of content\). More important than the content will be the _page structure_ and _layout_. Make sure to include the following elements in your post as separate `<div>`s:
   * A header area \(with your blog title/subtitle, and maybe a splash photo\)
   * A navigation bar area \(with links to other pages in your Portfolio site\)
   * A content area for the text content of your post.
   * A footer with some contact info and copyright information.
3. Inside the content area, make sure that you've used at least one of each of the following:
   * A heading \(e.g. `<h2>`\)
   * A paragraph tag \(`<p>`\)
4. In a `<style>` tag in the head of the document, add some style for default HTML elements \(`<body>`, `<div>`, `<h1>`, `<h2>`, `<p>`, and whatever else you've included in your HTML up to this point\).
5. Give each `<div>` section its own unique `id` \(e.g. `navigation`, `header`, etc.\), and give each `id` some unique styles in the `<style>` tag. Maybe different `width`s or `background-color`s?
6. Add some `<span>` tags to some of the important text in your post, and give those `<span>` elements a `class` of `highlight`. Then add some special styles to those elements to make them stand out a bit from the rest of your post.
7. Stage, commit, push, and deploy your updated site!

## The CSS Box Model

Every HTML element has a box around it, even if you cannot see it. We can show a visible border around every HTML element on the page using the CSS border property and the "match all" selector:

```css
* {
  border: 1px solid red;
}
```

Try putting a border around each "boxed" element while you try out a few of the following properties:

1. The CSS padding property defines the extra space inside the border:

   ```css
   div {
     padding: 10px;
   }
   ```

   You can also assign different values to the `padding` on each side of an element with specific properties \(e.g. `padding-left`, `padding-right`, etc.\) or through the shorthand `padding` property. As an example, the following three `padding` constructs compile to the same appearance:

   ```css
   div {
     padding-top: 5px;
     padding-right: 10px;
     padding-bottom: 5px;
     padding-left: 10px;
   }
   ```

   ```css
   div {
     padding: 5px 10px 5px 10px;
   }
   ```

   ```css
   div {
     padding: 5px 10px;
   }
   ```

2. The CSS margin property defines the extra space outside the border:

   ```css
   div {
     margin: 30px;
   }
   ```

   The same shorthand rules that worked for `padding` also work for `margin`.

3. We can also manually set the width and height of the element itself.

   ```css
   div {
     width: 300px;
     height: 200px;
   }
   ```

   **What's the difference?** Check it out in the Elements panel of Chrome Dev Tools to inspect the spacing around the element.

   > NOTE: you can open the Elements panel with `CMD + Option + I` in macOS or with `CTRL + I` in Linux or Windows

### Portfolio Project 2

Now let's add some structure and spacing in our blog post! Try out the following:

1. Create a class called `container`, and apply it to every top-level `<div>`.
2. Give `container` the following CSS properties:

   ```css
   .container {
     max-width: 960px;
     margin: 0 auto;
   }
   ```

   What does this do? How does it work? And why would we want to do this?

3. For the rest of your already-defined elements, add some `padding` and `margin` values to give everything some space.
4. Add some borders using the `border` property, like we did in the first exercise.
5. Once you like the look of the page, stage, commit, push, and deploy your well-spaced site!

## Complex CSS selectors

As our documents grow, we'll need to leverage more complex CSS selection syntax. Here are a few important selectors to cherish and to keep:

1. _The Universal Selector_

   ```css
   * {
     /* css that applies to every element */
   }
   ```

2. _The Class Selector_

   ```css
   div.container {
     /* css that only applies to divs with a class of 'container' */
   }
   ```

3. _The Direct Decendant Selector_

   ```css
   div > p {
     /* css that only applies to direct child elements (no grand-children) of an element */
     /* in this case, all of the child paragraph elements of divs across the page */
   }
   ```

4. _The Decendant Selector_

   ```css
   div p {
     /* css that applies to all descendants of an element of a certain type */
     /* in this case, all paragraph elements of divs across the page
        (even if they're nested in other elements, like spans or lists) */
   }
   ```

5. _The Direct Sibling Selector_

```css
div + footer {
  /* css that applies to the first footer sibling of a div */
}
```

1. _The General Sibling Selector_

```css
div ~ img {
  /* css that applies to all images that are siblings to divs */
}
```

These rules might seem like overkill right now, but they're extremely useful for when you have large stylesheets of CSS rules that apply across multiple pages. Speaking of which...

## Pseudo-stuff

There are some selectors that can be used to make some very basic calculations about the state of your markup, and add styles accordingly. These aren't real classes or selectors, since they aren't able to select anything on their own. Rather, these are used to filter the results of a selector into a useful subset of HTML elements to style. Here are a few of the most useful:

1. `:first-child`

   ```css
   li:first-child {
     /* applies to the first list item of every list */
   }
   ```

2. `:last-child`

   ```css
   li:last-child {
     /* applies to the last list item of every list */
   }
   ```

3. `:nth-child(n)`

   ```css
   li:nth-child(2) {
     /* applies to the second list item of every list */
   }
   ```

4. `:nth-child(an)`

   ```css
   li:nth-child(2n) {
     /* applies to every other list item of every list */
   }
   ```

5. `:hover`

   ```css
   li:hover {
     /* applies to every list item the user is hovering over */
   }
   ```

