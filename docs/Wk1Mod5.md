## CDNs, Third-Party Dependencies, and Responsive Grids

Okay, so we've learned that doing layout with CSS by hand is confusing, inconsistent between different browsers, resolutions and devices and just generally a great, big pain in the button. Luckily, CSS frameworks exist!

You should consider using a framework or library to do the following:

- standardize CSS styles across browsers
- import some pre-built components (like buttons or icons)
- make your page look nice

Many frameworks do all three. For today, we'll take a look at some external resources that will help us with each point in turn. But first: how do we include these third-party libraries? In the case of CSS libraries, we'll use something called a **CDN**.

### CDNs

Content Delivery Networks are distributed networks that focus on minimizing the distance between your users and the assets that your site needs to render correctly. Think of CDNs as a giant interconnected set of servers around the world, responding as quickly as possible to users near them. This can be a great performance boost when using third-party libraries!

There are a number of popular CDNs, but the one we'll be using is called [CDNJS](//cdnjs.com). It's the world's largest open-source CDN, with its source code available for free [on GitHub](https://github.com/cdnjs/cdnjs).

There are thousands of open-source JavaScript and CSS libraries available from CDNJS, but we'll start out with [normalize.css](https://cdnjs.com/libraries/normalize).

---

### `normalize.css`

Remember the default styles applied to common elements like `<h1>` and `<ul>`? Well, those styles are sometimes different across browsers, and they're usually filled to the brim with quirky (or bug-causing) behavior. We want to have control over every aspect of our style across every browser. To do that, we need to normalize or reset styles to make sure that every browser treats our elements the same. We can also use a reset to modernize some out-dated features (like `box-sizing : border-box;`).

To do this, we'll add `normalize.css` from CDNJS in the `head` of our HTML files, like so:

```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.0/normalize.css">
```

---

### Web Fonts

By now, we've learned about `font-family`, including a few of the web's built-in fonts. There are a number of families that can be used across operating systems, but it's sometimes difficult to pick a set of families that will work identically across all browsers all the time.

If you're using built-in fonts, be sure to check [cssfontstack.com](https://www.cssfontstack.com/) to make sure that you're getting good font coverage.

The alternative would be to use a third-party font! There are a number of ways to do this. We could:

1. Serve up a custom font to our users through the [`@font-face`](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face) CSS directive
2. Use another CDN that focuses on serving fonts

For this course (and for 90% of projects out there), we'll be using a CDN hosted by Google called [fonts.google.com](//fonts.google.com).

![google fonts](https://i.imgur.com/dYgjrAj.png)

Here, once again, we can pick all the fonts that we would like to include, bundle them up as a single CSS dependency, and add them to the `<head>` of our documents as `<link>` tags.

Give it a try!

---

### Icons and Font Awesome

Some fonts are used not for typography, but for _iconography_. Think of how many interactions on the web are based on recongnizeable pictures instead of words... checkmarks, social media icons, back arrows, email icons, etc. Just like with fonts, there are a few different ways of getting using icons like these on the web:

1. We could use built-in [unicode characters](http://www.fileformat.info/info/unicode/char/a.htm)
2. We could use [emoji](http://caniemoji.com/)
3. We could use a third-party font library hosted from a CDN

For a number of different reasons (all similar to our reasons for using `fonts.google.com` instead of a default web font), we'll go with option 3. The third-party font service that we'll use for this class is called [Font Awesome](https://fontawesome.com/).

Take a look at [this page](https://fontawesome.com/get-started/web-fonts-with-css) for a snippet that we'll use to add icon fonts to our projects.

Once the snippet above has been added to the `<head>`, you'll now have access to [all of these icons](https://fontawesome.com/cheatsheet) through the `.fas` and `.fas-*` classes applied to an `<i>` element.

#### Portfolio Project 1

1. Apply a Google-hosted font to all of a single type of `h*` element. Make sure that font applies to every instance of that element across your site!
2. Add social icons (like `.fas-github`) to your footer. Can you make them links to your actual social media profiles? HINT:

   ```html
   <a href="some-social-media.com">
     <i class="fas fas-some-social-media"></i>
   </a>
   ```

---

### Grids

Generally speaking, CSS from the last decade has worked with the paradigm of "boxes"; content would have some padding, a border, and some margin, and it was up to each piece of content to declare how those parts of their individual box would interact with the content dimensions and the dimensions of that content's parent elements. This worked well enough for layouts while websites were simple and could be thought of as "pages" (like a newspaper).

But as it turns out, this model does _not_ work so well when web _pages_ become more interactive web _applications_. Nor does this model work well when screen sizes vary not by a few hundred pixels, but by a factor of 10 (i.e. 320px for the smallest mobile phones to 3440px for ultra-wide monitors).

To create more complex layouts, developers needed better tools that were able to _respond_ in more flexible ways to user input and varying environments. We've already encounted a few of those tools in the use of `%` as a unit, and in the use of `display: flex` in two-dimensional containers. But what about layouts?

For responsive layouts, we now have `display: grid`. Grids make it easier than ever to wildly adjust the arrangement and layout of a web application without needing to use JavaScript. Let's work through an example!

#### Portfolio Project 2

Currently, our page layouts are using a sticky navigation bar optimized for mobile layout. But that mobile-optimized navigation bar takes up precious vertical space on wide monitors, all while restricting space for the content to a narrow field. What if we could turn that sticky navigation bar into a more useful sidebar when the user's screen is wide enough?

1. Let's start by getting rid of all `position: fixed` and `width` rules on the `#navigation` and `#footer` elements. We'll delegate that responsibility to the grid!
2. You'll notice that last step probably broke our layout a bit. Let's see if we can get that top-to-bottom flow back with `display: grid`. Start by adding the following CSS rules to the `body` of your page, like so:

   ```css
   body {
     display: grid;
     grid-template-areas:
       "navigation"
       "header"
       "content"
       "footer";
   }
   ```

3. Look at that wild syntax! This will make more sense in a minute, but imagine each line as a row in our layout, and each set of quotes a column. So this is a four-row, single-column grid. Take a look at your developer tools in the browser: you'll notice that the names we've used above are also used to distinguish the areas of our layout. That'll come in handy soon!
4. You'll also notice that our content is scrunched up towards the top of the page. Let's make sure that this `body` element is allowed to grow taller than the viewport, but is never smaller than 100% of the viewport height. That would mean that our `body` CSS is now:

   ```css
   body {
     display: grid;
     grid-template-areas:
       "navigation"
       "header"
       "content"
       "footer";
     min-height: 100vh;
   }
   ```

5. This is closer, but the content of each template area is taking up exactly 1/4 of the vertical height of the screen. That's not what we want, either! What we want is for every element to take up the minimum possible height allowed by its content, except for the `content` area, which should fill up whatever remains after the `navigation`, `header`, and `footer` areas have alloted space for their content. We can accomplish this with the `grid-template-rows` rule, which defines how our four rows should behave. In this case, our `body` CSS will now look like this:

   ```css
   body {
     display: grid;
     grid-template-rows: min-content min-content auto min-content;
     grid-template-areas:
       "navigation"
       "header"
       "content"
       "footer";
     min-height: 100vh;
   }
   ```

6. Now our spacing is correct, but we've lost the `fixed` behavior of our toolbars. But we can't use `position: fixed` on our navigation and footer sections, since that would pull those sections out of the grid that we just set up to control the relative dimensions of that element. Instead, we're going to use something called `position: sticky` to allow for our toolbars to "stick" to the edge of the viewport without destroying the grid. Try something like this:

   ```css
   #navigation {
     position: sticky;
     top: 0;
   }

   #footer {
     bottom: 0;
     position: sticky;
   }
   ```

7. You'll recognize the `top` and `bottom` attributes from our previous efforts with `position: fixed`, but now those constraints only take affect when our element makes contact with the edge of a viewport. So we've regained, now, our previous feature set, but we haven't yet added a way of turning our navigation bar into a sidebar for wide screens. To do that, we'll need something called a **media query**, which will have the following format:

   ```css
   @media (min-width: 612px) {
     body {
       /* some CSS that only apply when the viewport width > 612px */
       background-color: hotpink;
     }
   }
   ```

8. Make sure to put the media query from step 7 at the very bottom of the page, since we don't want to battle specificity for these viewport-width-specific CSS rules! What rules could we modify to bring the navigation bar over to the side of our content? Try the following:

   ```css
   @media (min-width: 612px) {
     body {
       grid-template-columns: 10rem auto;
       grid-template-rows: min-content auto min-content;
       grid-template-areas:
         "navigation header"
         "navigation content"
         "navigation footer";
     }
   }
   ```

9. And with that, we should now have containers that are mobile-responsive! Spend whatever time remains in class making sure that your dropdown menus and links to other pages still work, and make sure that these rules apply to your landing, blog, and project pages.
