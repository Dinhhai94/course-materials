# Hack-a-thon \#1: Student Showcase

## A Savvy Coders Hack-A-Thon

It's almost time to use what we've learned above to create a Student Showcase for you and your classmates. First, though, we need to learn about how to work on shared codebases through `git` and GitHub. While this can be pretty complicated, you'll find that it gives us a lot of power as a team!

### The GitHub workflow

![the GitHub workflow](https://camo.githubusercontent.com/0951c54f2f51742fb106fa9146082f41af4d894a/68747470733a2f2f677561726469616e70726f6a6563742e696e666f2f77702d636f6e74656e742f75706c6f6164732f323031332f31312f696e746567726174696f6e5f6d616e616765725f776f726b666c6f772d333030783132312e706e67)

For all of our group projects at Savvy Coders, we'll be using the 'Blessed Repository' workflow, simplified a bit for our needs. The important thing to remember with this workflow is that there will be LOTS of copies of the same codebase with little variations between each copy. The copies shown in the chart above are:

1. **The Blessed Repository**: this is the "product"... the fully-merged and up-to-date codebase that will be managed by your instructor. Each student will have the ability to copy \(or `fetch`\) data from this repository, but won't be able to directly change \(or `push`\) anything on the Blessed Repository. _This repository is hosted on GitHub_
2. **Integration Manager's Personal Copy**: "integration manager" is a fancy term for the person in charge of merging everyone's changes together. Developers don't have direct access of any kind to the IM's personal copy of the Blessed Repository. The IM will be your instructor/team leader for the night!
3. **Developer's Public Copy**: each of you will have a copy \(or 'fork'\) of the project hosted on GitHub. All changes made to Blessed Repository will have to be submitted through your public project repo \(more on that later\).
4. **Developer's Private Copy**: GitHub will only store your code. You'll need a local copy to edit files, and you'll sync that local copy with your public repository and the Blessed Repository.

The goal will be to keep your Public and Private copies as close to the Blessed Repository as possible at all times without causing merge conflicts or overwriting your work!

## Student Showcase Project Part 1:

### Setting up project repos

Follow these steps to get a copy of the boilerplate code set up on your GitHub profile and your local machine.

1. Your instructor will have a forked copy of our boilerplate code on their GitHub profile. You will need to go to your GitHub profile and fork your instructor's copy. You now have your public copy set up!
2. Next, you'll need to `clone` your public copy onto your local machine. In your public repository, find the button that lets you copy down an https address pointing to your public repo. Then use that address on your local machine. To clone the repo at that address, fire up a terminal, navigate to your `SavvyCoders` directory, and type in:

```text
git clone [address you copied from GitHub]
```

1. Now you should have a copy of the entire GitHub repository on your local environment. Try to `cd` into that directory, then open it with the command `code .`
2. In this repository, there is a README.md file that introduces the class to the outside world. Add your name to the list of contributors, then `add`, `stage`, `commit`, and `push` your changes to your public copy on GitHub.
3. Next, it's time to get those changes incorporated into the rest of the group's codebase. To do that, you'll need to submit a **pull request** to your instructor's account. That means going to your GitHub account, clicking on the 'Pull Request' button, and waiting for your instructor to merge your changes.
4. Once your pull request has been accepted and closed, you'll need to refresh your copies of the codebase with the newly-merged changes on your instructor's account. To do that, you'll need to set up that account as a `remote`. If you type in `git remote`, you should see a single remote, called `origin`, availabe to you. This remote was set up automatically when you ran `git clone`, and points to your public copy on GitHub. Anyone can set up a `remote` to `pull` from any repository, but only _you_ have `push` access to the repositories on your GitHub account. The same applies to your instructor's copy: you can set up a remote to `pull` data, but you can't use that remote to `push` to it. To set up that remote, navigate to your instructor's public copy of the codebase on GitHub, copy that repo's https address \(just like you did on your own account with `clone`\), and type the following into your console:

```text
git remote add merged [url for the instructor's repository]
```

1. Now, when you type `git remote`, you should see two remotes: `merged` and `origin`. To update your copies from the instructor's repository, follow the following steps:
   1. `fetch` all of the data from your remotes:

      ```text
      git fetch --all
      ```

   2. `reset` your current copy to the `master` branch from the `merged` repository:

      ```text
      git reset --hard merged/master
      ```
2. At this point, you should see all of your classmates' names in your README.md file! Now, whenever you would like to make a change to the group's project, you can use your `remote`s to `push` `commit`s, make a pull request through GitHub, and `fetch` data from the `merged` remote to `reset` your local codebase.

### Building the Student Showcase

Now that you've messed with the README.md, it's time to add your own face to the Student Showcase! The Student Showcase is built using the same minimal.css library we visited earlier. Each block should represent one of you, and link to your portfolio website. Go through the following steps to add your information to the Showcase:

1. Choose a block! Everyone gets a block, but you need to communicate which is yours. Don't touch blocks that aren't yours! If two people modify the same code, there will be merging conflicts \(which will make your instructor sad\).
2. Add your content! Every block should be a click-able link to your portfolio page, and it should include:
   1. the same picture used on your portfolio page
   2. the same unordered-list of contact information
   3. a funny quote

      Make sure that you have all of that content in before you start to style the page!
3. Now make sure that each block has a unique ID, and add some unique styles to your block in the group's CSS stylesheet.
4. Be sure to commit your work periodically, submit new features as pull requests, and `fetch` data from the `merged` repository after every pull request.

When class is done, your instructor will deploy your site through Netlify for your viewing pleasure. Good luck!

