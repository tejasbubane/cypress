---
title: window
comments: false
---

Get the global `window` object of the remote application that was visited in {% url `cy.visit()` visit %}.

# Syntax

```javascript
cy.window()
cy.window(options)
```

## Usage

`cy.window()` cannot be chained off any other cy commands, so should be chained off of `cy` for clarity.

**{% fa fa-check-circle green %} Valid Usage**

```javascript
cy.window()    
```

## Arguments

**{% fa fa-angle-right %} options** ***(Object)***

Pass in an options object to change the default behavior of `cy.window()`.

Option | Default | Notes
--- | --- | ---
`log` | `true` | Whether to display command in Command Log

## Yields

`cy.window()` yields the `window` object.

## Timeout

`cy.window()` will retry for the duration of the {% url `defaultCommandTimeout` configuration#Timeouts %}.

# Examples

## Window

**Returns the remote window object**

```javascript
cy.visit('http://localhost:8080/app')
cy.window().then(function(win){
  // win is the remote window
  // of the page at: http://localhost:8080/app
})
```

## Options

**Passes timeout through to {% url `.should()` should %} assertion**

```javascript
cy.window({ timeout: 10000 }).should('have.property', 'foo')
```

# Command Log

**Get the window**

```javascript
cy.window()
```

The commands above will display in the command log as:

![Command Log](/img/api/window/window-command-log-for-cypress-tests.png)

When clicking on `window` within the command log, the console outputs the following:

![Console Log](/img/api/window/console-shows-the-applications-window-object-being-tested.png)

# See also

- {% url `cy.visit()` visit %}
- {% url `cy.document()` document %}