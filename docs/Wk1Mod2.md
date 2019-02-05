## node, `npm`, developing with `localhost`, and HTML5

---

### Warm Up:

1. Use VSCode to add a fun fact about yourself to the `README.md` file in your project directory.
2. `stage`, `commit`, and `push` your changes to GitHub
3. In `index.html`, add a line of `lorem ipsum`.
4. `stage`, `commit`, and `push` your changes to GitHub
5. Verify that your new `index.html` content has been deployed through Netlify

---

### Local Development

As we delve deeper into the world of web development, we'll find that the structure of our websites generally mirror the structure of our file system (more on this later). But they are _not_ exactly the same thing... we need to use a special program called a "server" to "serve" our content to users when requests are made from the browser. You could, in fact, open up files directly in the browser, but this introduces some subtle differences between the way our content is previewed locally and served on the web when we push our work to Netlify (or any other hosting platform). Instead, we're going to be using a server called [`http-server`](https://www.npmjs.com/package/http-server). `http-server` is built for development, and can be run from the command line, updating our website as we make changes. Before we get to that, though, we need to set up our project for use with `http-server`.

#### `node` and `npm`

So far we've only used one very basic programming language from the command line. That's right, all of those `ls` and `cd` commands are run through a basic programming interface. It's a language all its own, although we won't dig too much deeper into its more powerful features. But you can also use a number of other programming languages in the command line, including JavaScript! `http-server` happens to be built with JavaScript, so we'll need to install the JavaScript command-line runtime environment (called `node`) and its dependency management system (called `npm`).

This can be a pretty complex process, so we've created a shell script (an executable file written in the shell scripting language) that helps you a bit with the installation process for these tools. You can download that remote file and `pipe` it to your terminal with the following command:

```shell
curl -o- https://raw.githubusercontent.com/NAlexPear/savvy-course-materials/master/init.sh | bash
```

This script is a bit advanced for right now, but feel free to go to the URL above, and try to figure out what's going on behind the scenes!

If the initialization script has run correctly, we should have access to four new commands: `node`, `npm`, `parcel`, and `http-server`. You can verify that these programs (or any program) have been installed correctly by using the `which` keyword. This command will give the path to the installation location of its argument, or will output nothing in the event that the given program hasn't been properly installed. To make sure that everything is working at this point, try running `which http-server` to make sure that our dev server has installed correctly.

#### `http-server` and `localhost`

At this point, you should have a single `index.html` file at the root of your project directory (`FirstnameLastname`). To start up a development server that behaves like Netlify would, run the following command in your terminal from _inside your project directory_:

```
http-server
```

Once you've done that, you should see some text giving you a quick status update on the state of the server, followed by something like:

```shell
Starting up http-server, serving ./
Available on:
http://127.0.0.1:8080
http://192.168.1.4:8080

Hit CTRL-C to stop the server
```

Let's take a look at the third line. What does `http://` tell us? In this case, it means that we're able to communicate with our development server using Hyper Text Transfer Protocol... the same way that our browsers communicate with any website, including our Netlify site. The `127.0.0.1` is the _IP address_ of our development server. All websites have IP addresses, but most are hidden to us behind a _domain name_. `localhost` is the domain name associated with your local IP address (`127.0.0.1`), and is a special domain name accessible only to you and your local machine. The `:8080` is a `PORT` number. Servers can communicate over thousands of different channels (called ports) at once. We've chosen port `:8080` to serve this set of content.

The key realization here is that there is a 1:1 relationship between our file structure and the URL structure that we see in our browser! Think of `localhost:8080` as an alias of `~/Code/SavvyCoders/FirstnameLastname`, and you'll be on the right track.

> NOTE: At this point, you might be thinking, "what about our `index.html` file? Why isn't our url `http://localhost:1234/index.html`"?The answer is that browsers know to look for `index.html` files by _default_. This is, incidentally, one of the ways that we're able to generate pretty URLs like `http://example.com/blog` instead of `http://example.com/blog.html`.

### HTML

HTML (Hyper-Text Markup Language) is a markup language for describing the structure and content of web documents (web pages). It is comprised of markup tags and text content nested inside each other.
![standard HTML structure](http://reactorprep.herokuapp.com/assets/images/html_breakdown.png).

HTML tags are keywords (tag names) surrounded by angle brackets:

#### `<tagname> content </tagname>`

- HTML tags normally come in pairs like `<p>` and `</p>`
- The first tag in a pair is the start tag, the second tag is the end tag
- The end tag is written like the start tag, but with a slash before the tag name

By following the proscribed rules of HTML, a web browser understands this to be a document with a heading and a paragraph. Here is what the browser interpreter thinks when given (this code):

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Page Title</title>
  </head>
  <body>
    <h1>My First Heading</h1>
    <p>My first paragraph.</p>
  </body>
</html>
```

- The `!DOCTYPE` declaration defines the document type to be HTML
- The text between `<html>` and `</html>` describes an HTML document
- The text between `<head>` and `</head>` provides information about the document
- The text between `<title>` and `</title>` provides a title for the document
- The text between `<body>` and `</body>` describes the visible page content
- The text between `<h1>` and `</h1>` describes a heading
- The text between `<p>` and `</p>` describes a paragraph

---

#### EXERCISE 1

It's time to take a look at how browsers (like Chrome) render HTML content!

1. Create a new `example.html` file and paste in the following:

```html
<!DOCTYPE html>
<html>
<head>
<title>HTML EXAMPLE</title>
</head>
<body>

<h1>HTML Example 1</h1>
<p>[CMD + OPT + U] to view the source code of this HTML document.</p>
<p>Now close the source code and inspect the document in the Elements panel of your Chrome Developer Tools [CMD + OPT + I] instead</p>
<p>Use the magnifying glass in the top left to select elements in the window area.</p>
<p>
  W  O  A  h
    WHAT'S
  GO  -  ING
                    on


  h   e   r   e
              !
        !
  !
</p>
<!-- ALERT: THIS IS JUST A COMMENT -->

<!--

    SECRET: Developers often use comments to annotate their code.

            ...or complain about their bosses. They aren't rendered on the page.
            So only people who view the source code get to see them. Fun!

-->
</body>
</html>
```

2. Open up Chrome's Dev Tools and take a look at Elements and their associated STYLES:
   ![dev tools](http://reactorprep.herokuapp.com/assets/images/elements.png)

3. What `font-size` does the browser give an `<h1>` element by default?
4. What `font-weight` does the browser give an `<h1>` element by default?
5. How does the browser render the extra spaces and new lines in the last paragraph?
6. Are there any parts of the `body` that are not rendered into the browser window?

---

#### Portfolio Project 1

Now it's time to turn your `README.md` into a landing page for your portfolio site! Since browsers don't work with Markdown by default, we want to use HTML for our Portfolio on the web. Go through the following steps to get started:

1. Make sure that you're inside your portfolio project directory (called `FirstnameLastname`).
2. All browsers look for an `index.html` file to display by default. You can name other pages whatever you'd like, but the landing page for every site should always be `index.html`. We created this file last time, but verify that it's still there with the content you expect.
3. Edit `index.html` in VSCode. Make sure that it includes the following BEFORE we start porting in text from `README.md`:
  -. `<!DOCTYPE HTML>`
  -. `<html>`,`<head>`, and `<body>` tags
  -. `<title>` tags and a title of `Firstname Lastname | Web Developer`

_HINT: you can use emmet's HTML boilerplate by typing_ `!` _then pressing_ `TAB`

4. Then you can start moving content from `README.md` into `index.html`
  1. Use `<h1>` for headings
  1. Use `<p>` for paragraphs of text
  1. Use `<ul>` for unordered lists (and use `<li>` for each nested list element)
  1. Use `<hr>` to create an horizontal rule
5. Make sure you've saved the file!
6. Preview the file at `localhost:8080`

---

### More HTML tags

#### EXERCISE 3

Now let's replace the contents of your `example.html` file with this:

```html
<html>
  <head>
    <title>More styles!</title>
  </head>
  <body>
    <h1>This is a header</h1>
    <h2>This is an even smaller header</h2>
    <h3>Even smaller...</h3>
    <h6>Quite small</h6>
    <p>Here is some normal text. A paragraph, even!</p>
    <p><i>This text is in italics.</i></p>
    <p><b>This text is in bold.</b></p>
    <p><b><i>This text is in both.</i></b></p>
    <p><del>This text is rendered with strikethrough.</del></p>
    <p>Sometimes you want to embed some <i>stylized text</i> right into <b>your paragraph.</b> Pretty cool, right!</p>
    <p>You could BREAK <br> the line, but it's not used very often these days.</p>
    <hr>
    <ul>
      <li>Item</li>
      <li>Item</li>
      <li>Another item</li>
    </ul>
    <p>w/ sub-lists</p>
    <ol>
      <li>Item one</li>
      <li>Item two</li>
      <li>Item three
        <ul>
          <li>Sub-item</li>
          <li>Sub-item</li>
        </ul>
      </li>
      <li>Item four</li>
    </ol>
    <p><a href="http://www.google.com">I&#39;m a link to a web page!</a></p>
    <p><img src="https://i.imgur.com/81qyN1y.jpg" alt="This text will show up, only if the image doesn't (also good for screen readers)"></p>
    <p><img src="../../assets/images/profile.png" alt="local photo"></p>
  </body>
</html>
```

Then go to `localhost:8080/example.html` and answer the following:

1. What `font-size` does the browser give an `<h2>` element by default?
2. What `font-size` does the browser give an `<h6>` element by default?
3. What `font-style` does the browser give an `<em>` element by default?
4. What `text-decoration` does the browser give an `<a>` element by default?
5. What `list-style-type` does the browser give a `<li>` element?

#### Attributes

This link tag has an attribute whose name is `href` and whose value is a `url`:
![anchor tag](http://reactorprep.herokuapp.com/assets/images/links.png)

Attributes provide additional information about an element. They appear on the opening tag of the element and are made up of two parts: a **name** and a **value**, separated by an equals sign.

Image tags (`<img>`) have an attribute named `src` whose value is the location of the image to be displayed, like this:

```html
<img src="https://i.imgur.com/81qyN1y.jpg" alt="This text will show up, only if the image doesn't (also good for screen readers)">
```

---

#### Portfolio Project 2

Let's expand on the landing page we've already made for our online portfolio!

While it's possible to link to HTML documents in your website with any name (as long as they have the `.html` file extension), it's generally considered best practice to create new directories for each page. At the root of each new directory should be another `index.html` file. This makes the URL prettier when users search your site, and it organizes things a bit better for future developers. Let's set up a 'Projects' page using this method:

1. If you're already in the Portfolio page's root (or top-level) directory, make a new directory called 'projects' (HINT: `mkdir projects`). Remember that different capitalizations are different addresses, so keep a consistent naming convention for all folders (i.e. don't capitalize any words, and separate multi-word directory names with hyphens, e.g. `my-favorite-directory` instead of `MyFavoriteDirectory`).
2. Now navigate into your newly-created projects folder (HINT: `cd projects`) and create another `index.html` file (HINT: `touch index.html`).
3. Use VSCode to edit your new `projects/index.html` file.
4. Set the page up just like any other HTML document (see the emmet shortcut).
5. Give the page a `<title>` of `Firstname Lastname | Projects`.
6. Add an **ordered list** (`<ol>`) of the following projects (hint: `ol>li*3 + TAB`):
   - Class Showcase
   - Web Store Hack-A-Thon
   - Demo Day Project
7. Now go back to your landing page (`/index.html`), and edit that file to include the following:
8. The profile image from `README.md`
9. The social media links from `README.md`
10. A "navigation list" at the top of your landing page, with links to 'Home' (`/`) and 'Projects' (`/projects`).
11. At least one comment for future developers (or you!) using the syntax `<!-- comment text -->`

---

### More HTML elements

#### Portfolio Project 5

Now it's time to add a few more elements to our Portfolio Project pages.

1. Anchor tags (`<a href=""></a>`) have been used already to link to websites using `http` or `https`. They can also be used to automatically draft an email and open it in a browser window for users to send! Try the following:
   1. On your landing page, add a 'Contact Me' link.
   2. Inside the `href` attribute, use `mailto:` + your email address instead of `http:` + a website URL. Your new element should look something like `<a href="mailto:your.email@example.com?Subject=Contact%20Form">Contact Me</a>`.
2. Stage, Commit, Push and Deploy your new landing page!

---
