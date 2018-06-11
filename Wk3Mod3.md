

## Portfolio Project 1
### Adding Effects

There are _lots_ of events to learn about. Let's try a few by adding them to the JavaScript files for the landing page of our Portfolio Projects.

1. Add some CSS rules for a class called `highlighted`. Maybe make the text bolder, or change color, or change the opacity of the background... it's up to you!
2. Add the following to your JavaScript file:

```javascript
$('li').on('mouseover', () => {
  $('li').addClass('highlighted')
})
$('li').on('mouseleave', () => {
  $('li').removeClass('highlighted')
})
```

How does this work?
3. Let's add a click handler for your face. When users click on your photo on your profile page, a previously-hidden blurb should be revealed with a jQuery animation. There are lots of options here, but something like this should work:

```javascript
$('#profile-pic').on('click', () => {
  $('#hidden-blurb').slideDown(); // only works if #hidden-blurb has display:none; in its CSS
});
```

---

## `this` and `event`

We've already seen once before how we can pass in an `event` Object to an event handler. That argument has a few properties associated with it, like `.preventDefault()` (take a look at the Hack-A-Thon code to see what we mean.) One of those properties is the __calling context__ of the event... the thing that is triggering the event. Try modifying your code from your Portfolio Project to something like this:

```javascript
$('li').on('mouseover', (event) => {
  var target = event.target;
  $(target).addClass('highlighted');
})
$('li').on('mouseleave', (event) => {
  var target = event.target;
  $(target).removeClass('highlighted');
})
```
Now only the hovered-over element is highlighted (which is very much the behavior that we're really looking for in a highlighter). This operation is so common with events (and with functions in general), that JavaScript generalizes the calling context for any function into a `this` keyword. In the case of jQuery events, the calling context of the function is equal to the DOM node from which the event originated (a.k.a. the `event.target` from the previous example). Try the following refactor (it should work the same as `event.target` in this case):

```javascript
$('li').on('mouseover', function highlight(){ // notice: no arrow function!
  $(this).addClass('highlighted')
})
$('li').on('mouseleave', function highlight(){
  $(this).removeClass('highlighted')
})
```
---

## Portfolio Project 2
### Adding `this` effects

With the time remaining in class, try out a few of jQuery's built-in event shortcuts, including `.click()`, `.hover()`, `.submit()`, and `.keypress()`. Add an effect or animation on each event using `this` to capture the calling context of the target element. When you're happy with your fancy new event-driven site, push your changes to your GitHub profile and live to Netlify!
