# Dagwood
## The simple static site generator

Dagwood is a static site generator that prides itself on minimal configuration, built in SEO, and ability to quickly product fast-loading websites.

### Skills you need to build a successful Dagwood Site
To build a Dagwood site, you will need some level of proficency with:
- HTML
- CSS
- Markdown
- A fundamental understanding of YAML.

That's it!

### Installing

### Create your first site
```bash
# Use dagwood to create a new site in the folder "my_personal_blog"
dagwood create my_personal_blog

# Change into the newly created site directory
cd my_personal_blog

# Compile the posts, pages, and template and produce HTML
dagwood build

# Serve your built site on your local network
dagwood serve
```

### So, how's this all work?
Glad you asked.
- The `pages` folder is for static HTML. Go crazy with this. As long as its valid HTML, its a valid page. Folder paths will be preserved.
- The `posts` folder contains your blog posts in the Markdown `(.md)` format. However, they're a little special. The top of each post should have a Yaml block that defines the metadata for the post (this gets processed and generates the SEO tags for your post).
- The `post-template.html` is an HTML that all of your markdown posts get wrapped inside. There  are two special blocks here `{{dagwood:meta}}` and `{{dagwood:content}}`. If your post-template.html does not have these blocks, dagwood will not render the post metadata (the YAML) or the actual blog post content (the Markdown) respectively.

### How do I create new posts with Dagwood?
Copy/Paste.

There is a shell of a command to help you do this and i'll work on developing that out soon. :)

### Whats the right way to structure my posts with Dagwood?
However you want. Folder structure gets copied over inside of the posts folder. This means that a posts folder that looks like this:
```
├── post-template.html
├── posts
|   ├── how-to-build-a-dagwood-site.md
│   ├── 2020
|   |   ├── january
│   │   |   ├── my-january-post.md
```
then your build output will look like this:
```
├── build
|   ├── how-to-build-a-dagwood-site.html
│   ├── 2020
|   |   ├── january
│   │   |   ├── my-january-post.html
```

This means that if you serve your `build` folder from sample.com, you would have a post at `sample.com/how-to-build-a-dagwood-site.html` and `sample.com/2020/january/my-january-post.html`

## Contributing
Wanna contribute? More info coming soon!
