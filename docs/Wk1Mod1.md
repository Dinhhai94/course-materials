# CLIs, `git`, and "Hello, World"

## Welcome to the first class!

### Housekeeping

To get things started, we need to download a few things for our **development environment**. These include the following:

1. A bash-friendly command-line interface
2. A version-control system
3. A text editor
4. A dependency-management utility
5. A native client for Slack

The process for each of these things should depend a bit on your operating system, but should help us work together in a consistent environment for the rest of the course.

You'll also need a few online accounts to get started. These should _all be tied to the same email address_! These external accounts include:

1. Slack
2. GitHub
3. Netlify

We'll set them up together as we work through tonight's materials.

### Building a Dev Environment

*Update:* The Savvy Coders 📓 now has a [video series](https://www.notion.so/codefinity/Setting-up-a-Local-Dev-Environment-97de62a546f943fbbc7a246b4785a343) that you can work through before reading through this.

Whenever we work on a project, we want to make sure that we are using a consistent set of tools. But installing those tools in a way that is consistent across operating systems is a tough problem! Most web developers use tools that are modeled after the UNIX family of operating systems. These tools are usually packaged as a form of **terminal emulator**.

Because each operating system is so different, we'll need to install a different set of tools to emulate the UNIX terminal through our command-line (more on "command-lines" and "terminals" in a minute):

#### Linux

- Most Linux distributions ship with their own, fully-featured UNIX-based
  terminal emulators. Popular examples include GNOME Terminal, xterm, or
  Konsole (depending on your desktop environment).
- If you're using a minimalist distribution like Arch,
  please use [kitty](https://sw.kovidgoyal.net/kitty/), installed through your
  distribution's package manager (e.g. `pacman -S kitty` for Arch users).

#### macOS

- For Mac users, the Terminal application works well as a UNIX-compliant
  command-line.
- If you would like a command-line application with more features, [iTerm2](https://www.iterm2.com/) is the _de facto_ choice of many devs.
- For some versions of macOS, you will also need to consent to using XCode
  features. To trigger this installation/consent process, type in `git --version` and hit `ENTER`. If a version number is output to the screen,
  you're good to go. Otherwise, follow the prompts to make sure that you're
  set up with Terminal dev tools.

#### Windows

- Windows is the tough one...the windows command line is notoriously _wrong_
  for web development. Luckily, the folks behind `git` have come up with a
  solution: `git-bash`, a UNIX-esque terminal emulator for Windows packaged
  with `git`!
- Do download both `git` and `git-bash`, head to [git-scm.com](https://git-scm.com/downloads), hit the "Downloads for Windows" button, and go through the prompts to complete the installation process.
- Once the installation process above is complete, use the Windows key to
  search for "Git Bash". Use this command-line for the duration of this
  course.

#### For All Platforms...

...you could use [Hyper](https://hyper.is/), although some folks feel that it's a bit resource heavy. 🤷🏾‍♂️

### Interfacing with Computers

The operating system is the program (series of instructions) that runs when you turn on your computer. It handles inputs (keyboard, mouse, camera, network connections) and outputs (monitor, speakers, network connections), manages shared access to computing resources and memory, and reads and writes data to the file system on behalf of any number of simultaneously running applications (web browser, code editor, terminal emulator, music player, etc). We interact with the computer through the operating system, usually by TYPING, TOUCHING, or CLICKING.

Computers can receive user input through either a command line interface (CLI) or a graphical user interface (GUI). In a command line interface (A.K.A. "Console", "Command Line", "Terminal", or "Shell"), the user types commands using the keyboard to tell the computer to take an action. The computer will display the results of the operation by writing text to the screen.

![Command-Line GIF](http://reactorprep.herokuapp.com/assets/images/cli.gif)

GOAL FOR THE COURSE: All navigation should be done using **words** instead of **pictures**, usually through our terminal emulators.

> "When I was a child, I used a computer by looking at the pictures. When I grew up, I learned to read and write."
> -William Shotts, Jr.
> Linux Command.org

> **NOTE**: From here on out, we'll use the terms `terminal`, `command-line`, and `CLI` interchangeably

---

#### EXERCISE 1

We will start out by using the CLI to navigate through the file system on our personal computers. The key is to think of the directory structure as a 'tree' with 'branches', rather than a bunch of 1s and 0s stored in memory. The OS abstracts all of that memory management away, so you and I can work directly with the human-facing interface we call a file structure.

1. Open up your terminal of choice and type in `pwd`. What do you see?
2. Make a note of that folder's location, then repeat the process with your CLI
3. print your starting location: `pwd`
4. list the file structure: `ls`
5. change directories: `cd`
6. move up a directory: `cd ..`
7. move to your `$HOME` directory: `cd ~`
8. In your `$HOME` directory (`~`), create a folder called `Code` for all of your future coding projects. You can do that with the `mkdir` command (e.g. `mkdir ~/Code`)
9. Inside of `Code`, create a `SavvyCoders` directory for all of your Savvy-related work! You can do that with the `mkdir` command (e.g. `mkdir ~/Code/SavvyCoders`).

---

### Developer Accounts

There are a number of different online services that help us be productive. Here are three that we'll use for this class.

#### Slack

All of our communication will go through the class-specific Slack channel! Please sign up for an account (if you haven't already) and download the slack client for your OS through your package manager.

#### GitHub

[GitHub](https://github.com) profiles are like a combination of LinkedIn and Facebook for developers, as well as a place to back up and store code. We'll learn more about how git and GitHub work later, but for now, it's important to create an account. When you've created an account, post a link to Slack, and follow the profiles of your classmates and instructors!

#### Netlify

Once you have a GitHub account, you can sign up for [Netlify](https://www.netlify.com/). We'll use Netlify for [Continuous Delivery](https://en.wikipedia.org/wiki/Continuous_delivery)

---

### More Environment Tools

Beyond a package manager and CLI, we need a few more tools to help us work more efficiently.

#### `git`

Most Linux distributions come with `git` pre-installed, as does macOS. For
Windows users, we already installed `git` as a part of downloading `git-bash` as
your terminal emulator.

Verify that you have `git` installed by typing `git --version` into your
terminal. You should see some numbers (e.g. `2.17.1`).

In some versions of macOS, you will need to install XCode tools before using `git`. This can be done in response to a series of prompts that will appear when you type `git --version` for the first time.

#### Visual Studio Code

The text editor that we'll be using for this course is called [Visual Studio Code](https://code.visualstudio.com/) (_not_ Visual Studio, which is only available for Windows). It's a modular editor built for web development, maintained by Microsoft, and contributed to by a large Open Source community.

Visit the link above to install VSCode (as it's colloquially known) to your
machine. Linux users can also use their distribution's package manager.

Once you've installed VSCode, you should be able to open it from your terminal by typing `code` or by searching through your applications. Then, follow these steps to configure your editor!

1. Open up the Settings (`CTRL + ,`)
2. This is how we configure VSCode's internal settings, including things like
   font size and family, syntax highlighting theme, and indentation guides. Be
   sure to set "eslint.autoFixOnSave" to `true`
3. If you're on macOS, install shell commands from the command pallette (`CMD + SHIFT + P`) by selecting the `Install 'code' command in PATH` option.
   ![command-palette](https://code.visualstudio.com/assets/docs/setup/mac/shell-command.png)
4. Click the boxy icon on left-hand side of your screento install two _extensions_: [Live Share](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare) for real-time collaboration and [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) for code formatting in JavaScript-land.

---

#### EXERCISE 2

1. Navigate to your `SavvyCoders` directory using your CLI
2. You can open specific directories in VSCode using the `code` command from your command line! If you have already navigated inside the `SavvyCoders` directory, you can open folder using `code .`
3. Also in your CLI, use the command `touch intro.txt` to create a new text file named `intro.txt` inside of `SavvyCoders`.
4. Write a short personal introduction using VSCode! Include some contact
   information and a favorite quote:

---

### Markdown

Formatted text is nice, but clicking buttons will never scale. We need to be able to programmatically describe how we want our text processed.

Markdown is a markup language. Markup languages mix in special sequences of coded characters to specify the intended layout and style of their text.

Copy this Markdown code into your VSCode code editor and search for 'markdown preview' to have it parsed and rendered:

```markdown
# This is a header

## This is an even smaller header

### Even smaller...

###### Quite small

Here is some normal text. A paragraph, even!

_This text is in italics._

**This text is in bold.**

**_This text is in both._**

~~This text is rendered with strikethrough.~~

Sometimes you want to embed some \*stylized text\*
right into **your paragraph.** Pretty cool, right!

- Item
- Item
- Another item

1. Item one
2. Item two
3. Item three

w/ sub-lists

1. Item one
2. Item two
3. Item three
   1. Sub-item
   2. Sub-item
4. Item four

---

[I'm a link to a web page!](http://www.google.com)

![alt text](https://i.imgur.com/81qyN1y.jpg)
```

#### EXERCISE 3

1. Now it's time to format intro.txt with Markdown! Let's `mv` `intro.txt` to a new file called `intro.md` with the command `mv intro.txt intro.md`
2. Create a title for your portfolio project and format it as a header with `#`
3. Format your quote using italicization and bold.
4. Create a list of contact information as an unordered list using `-`. Make
   each means of contact a link rather than plain text (e.g. `[some link](some-url.com)`)
5. Find a relevant photo online and insert it using the syntax `![ ]( )` (see the Markdown above for full syntax)

---

### Portfolio Project

Over the course of this class, you are going to build a Portfolio Page to practice your skills, introduce yourself to others, and demo all of the exercises and challenges that you complete in the next 4 weeks. To get started on this project, do the following:

1. Make a new directory called `FirstnameLastname` (with YOUR first and last name, of course) inside the `SavvyCoders` directory. (HINT: `mkdir FirstnameLastname`).
2. Navigate into your Portfolio Project directory (HINT: `cd FirstnameLastname`).
3. Remember your `intro.md` file in your Porfolio Project's parent directory?
   Let's turn that into a `README.md` file with the `mv` command: `e.g. mv ../intro.md README.md`. What does the `..` in front of `intro.md` represent?

---

### Version Control with `git`

To help us maintain, back up, and share our codebases, we're going to use `git` (the command-line tool) and GitHub (the online repository). These tools are fundamental parts of the web developer's workflow, and you'll be using them _every day_ for the rest of your programming career!

`git` works a bit like a Time Machine, in the sense that you'll be able to revert to any saved state within a directory. So if you mangle your site's directory structure, you can always use `git` to revert back to simpler times. The important things to understand about `git` specifically:

1. This is a CLI utility, so get ready for lots of text. All of our important files when programming will be text, so its only natural that we'd be navigating between save states (called 'commits') using text as well.
2. Arbitrarily or automatically saving code is NOT a feature of `git`, and it shouldn't be. You only want to save meaningful chunks of code (e.g. a feature), not broken pieces here and there. Otherwise, there's no way to revert back to a useful save-state!
3. Because of point \#2, 'saving' your progress with `git` is handled a bit differently. _You_ are in charge of 'staging' your commits, and 'committing' changes only when _you_ are ready.

![the git commit workflow](https://git-scm.com/images/about/index1@2x.png)

#### EXERCISE 4

Let's get our feet wet with `git` by configuring our user identity.

1. In any command prompt, type the following (using your name and email, of course):

   ```shell
   $ git config --global user.name "Firstname Lastname"
   $ git config --global user.email "your.email@example.com"
   ```

2. You can check all of your configuration settings by typing

   ```shell
   $ git config --list
   ```

That wasn't so bad, right?

#### EXERCISE 5

`git` works by creating a folder within the 'working directory' (the directory that you would like to track/save over time). The first step to saving any project, then, is to navigate to this 'working directory' and create that `git` folder (named `.git`). Let's set up your portfolio project as a `git` repository to track over time.

1. First, navigate to your `~/Code/SavvyCoders/FirstnameLastname` directory.
2. Next, while still the `FirstnameLastname` directory, type the following:

   ```shell
   $ git init
   ```

3. That _should_ have created a `.git` folder, which is hidden by default. There are two ways to make sure that our `git init` command worked. Try these both out:

   - list all of the hidden folders (including `.git`) in `FirstnameLastname`:

   ```shell
   $ ls -a
   ```

   You should see a folder called `.git` in the output.  Now try running a simple `git` command:

   ```shell
   $ git status
   ```

   If you get `FATAL: FirstnameLastname is not a git repository`, something has gone wrong. If everything worked, you should see something like this:

   ```shell
   $ git status
   On branch master
   Initial commit
   Untracked files:
     (use "git add <file>..." to include in what will be committed)
           README.md
   nothing added to commit but untracked files present (use "git add"    to track)
   ```

4. Once `git` is _initialized_ (`init` = initialize), we should be able start saving snapshots of our work. Before committing our work, though, we have to _stage_ our changes. You can do that with the following command:

   ```shell
   $ git add .
   ```

   That `.` at the end is very important! That's telling `git` to stage everything in the working directory at once. To make sure that everything worked, type in `git status` again. You should get output that looks something like this:

   ```shell
   $ git status
   On branch master
   Initial commit
   Changes to be committed:
     (use "git rm --cached <file>..." to unstage)
           new file:   README.md
   ```

5. As nice as it is to get this far, we **still** haven't committed our changes yet. So we wouldn't be able to roll back to this point in the event of error, because `README.md` is still waiting to be fully committed. Let's do that with the following command:

   ```shell
   $ git commit -m "First commit"
   ```

   `git` forces us to create a _commit message_ whenever a commit is made. This is a short snippet of text that helps you remember exactly what was changed in each commit. Normally committing and creating a commit are two different steps, but you can combine the two by adding the `-m` flag (for 'message'), followed by your custom commit message in quotation marks. If everything works as planned, you should see something like the following output:

   ```shell
   $ git commit -m "First commit"
   [master (root-commit) ee6ac27] First commit
    1 file changed, 3 insertions(+)
    create mode 100644 README.md
   ```

6. Now if you run `git log`, you'll see a list containing your entire `git` history (it should be pretty short at the moment). But we still only have _one copy_ of our codebase. To back up our work, let's use GitHub! The first step is to [create a new repository on online GitHub account](https://help.github.com/articles/create-a-repo/).
7. After you've created your new repository, you'll need to link that repo to your current project directory. You can do that with `git remote add origin https://github.com/YOURUSERNAME/YOUR-REPO-ADDRESS.git`. If you've done this correctly, you should see the word `origin` pop up in the command-line when you type `git remote`.
8. Now we need to **push** our local commit (called 'First commit', containing only the README.md file) to the remote repository. To do that, enter the following command:

   ```shell
   $ git push origin master
   ```

9. If that worked, you should see your `README.md` file appear in your GitHub GUI after a page refresh. Now you have two copies of your `git` repository... nice work!

---

### Hello, World

For your very first website, we're going to complete a quick `Hello, World` using HTML (more on that next time!).

1. Set up your Netlify account to track your Portfolio Project's GitHub Repository! Once these two things are connected, you'll be able to push "live" to your very own website with a simple `git push origin master`.
2. Be sure to name your Netlify site whatever you'd like (instead of the randomly-generated name provided).
3. Now we're going to make a landing page for your new site!
4. Create a landing page with the command `touch ~/Code/SavvyCoders/FirstnameLastname/index.html`
5. In VSCode, open up that new `index.html` file
6. Type in `!`, then hit `TAB`
7. You should now have some HTML boilerplate!
8. Inside the `<body>` tags, type in `h1{Hello, world!}` and hit `TAB` to see your very first HTML text.
9. Use `git` to `stage`, `commit`, and `push` your changes to GitHub
10. Netlify should automatically update your landing page, where you should see `Hello, World!` in a big, bold font.

And now you have your very own website! Congratulations.
