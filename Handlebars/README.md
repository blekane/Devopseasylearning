## Handlebars
- Using Handlebars Quick Start [here](https://gander.wustl.edu/~wilson/store/yui/docs/handlebars/index.html)
- Handlebars website [here](http://handlebarsjs.com/)
- An Introduction to Handlebars [here](https://www.youtube.com/watch?v=SPaw1ETzS2c&list=PLrafTkhP5sZzKQd31XOslFxtrL2yBP2Yg&index=10&t=1146s)

Handlebars is a logic-less templating engine that dynamically generates your HTML page. It’s an extension of Mustache with a few additional features

A Handlebars template is just some text that contains Handlebars expressions like {{foo}}. Although most people use Handlebars to generate HTML, it can easily generate JSON, XML, `YAML`, or any other plain text format.

![](/images/hand1.JPG)

When you render a template, Handlebars evaluates expressions and replaces them with data
![](/images/hand2.JPG)

## Expressions
The variables used inside the templates are surrounded by double curly braces `{{}}` and are known as expressions

```handlebars
<p>{{firstname}} {{lastname}}</p>
{{person.firstname}} {{person.lastname}}
```

```json
{
  firstname: "Yehuda",
  lastname: "Katz",
}
```
```html
#OUTPUT
Yehuda Katz
<p>Yehuda Katz</p>
```

## LOOPS
```handlebars
{{#each items}} ... {{/each}} or {{#items}} ... {{/items}} or {{#article}} ... {{/article}}

{{#each items}} 
... 
... 
... 
{{/each}}

OR

 {{#items}} 
 ... 
 ... 
 ... 
 {{/items}}
```

```html
<script id="list-template" type="text/x-handlebars-template">
    <p>YUI is brought to you by:</p>

    <ul>
        {{#items}}
            <li><a href="{{url}}">{{name}}</a></li>
        {{/items}}
    </ul>
</script>


<div class="header">
    {{#site}}
        <h1><a href="{{url}}">{{title}}</a></h1>
    {{/site}}
</div>

<div class="content">
    {{#article}}
        <h2>{{title}}</h2>
    {{/article}}
</div>
```

```json
{
    site: {
        title: 'AwesomeBlog',
        url: 'http://blog.example.com'
    },

    article: {
        id: 1,
        title: 'My blog is awesome'
    }
}


<script>
YUI().use('handlebars', 'node-base', function (Y) {
    // Extract the template string and compile it into a reusable function.
    var source   = Y.one('#list-template').getHTML(),
        template = Y.Handlebars.compile(source),
        html;

    // Render the template to HTML using the specified data.
    html = template({
        items: [
            {name: 'pie', url: 'http://pieisgood.org/'},
            {name: 'mountain dew', url: 'http://www.mountaindew.com/'},
            {name: 'kittens', url: 'http://www.flickr.com/search/?q=kittens'},
            {name: 'rainbows', url: 'http://www.youtube.com/watch?v=OQSNhk5ICTI'}
        ]
    });

    // Append the rendered template to the page.
    Y.one('body').append(html);
});
</script>
```

YUI is brought to you by:
```
pie
mountain dew
kittens
rainbows
```

## Escaping
In Handlebars, the values returned by the `{{expression}}` are HTML-escaped. Say, if the expression contains `&`, then the returned HTML-escaped output is generated as `&amp`;. If you don't want Handlebars to escape a value, use the `"triple-stash"`, {{{

```handlebars
I am learning {{language}}. It is {{{adjective}}}
```

```json
var context = {
  "language" : "<h3>Handlebars</h3>",
  "adjective": "<h3>awesome</h3>"
}
```

the resulting HTML will be:
```html
I am learning <h3>Handlebars</h3>. It is <h3>awesome</h3>
```
- {{ }} this will render a plain text
- {{{ }}} this will everything even if we a special character. This is a great example for password



## Block Expressions
![](/images/hand3.JPG)

## Built-in Block Helpers
Handlebars provides several built-in block helpers that are always available to templates.

### each 
The each helper iterates over an array. The block will be rendered once for each item, and its context will be set to the current item.
![](/images/hand4.JPG)

### with
The with block helper renders the given block in a different context. This can save you some typing in a template that will render a lot of namespaced data.
![](/images/hand5.JPG)

### if [here](https://handlebarsjs.com/guide/builtin-helpers.html#if)
```handlebars
{{# if condition}}
...
...
{{else}}
...
...
{{/if}}



{{# if condition}}
    condition is met
{{else}}
    condition is not met
{{/if}}
```

![](/images/hand6.JPG)

If we empty the users array and re-render the template, the list won't be included in the output.
![](/images/hand7.JPG)

We can add an `else` block to display an informative message when no users are online.
![](/images/hand8.JPG)

### unless (If there is not)
The `unless` block helper does exactly the opposite of the `if` helper: it renders the contents of the block if the provided value is falsy or an empty array.
![](/images/hand9.JPG)

## Comment Expressions
```handlebars
{{! I'm a Handlebars comment! I won't show up in rendered output. }}
<!-- I'm an HTML comment! I will show up in rendered output. -->

{{!
    I'm a multi-line comment!
}}

<!-- This won't work (it'll leave a trailing "}}" behind) -->
{{! {{expression}} }}
```