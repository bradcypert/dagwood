void printHelp() {
  print('''
      help
      --------
      
      Dagwood is a static site generator. You can use dagwood to create a new site,
      add pages or posts to an existing site, build your current site, and
      preview your site on your local machine.

      You may want one of these commands:

      If you want to create a new site try `dagwood create my_site_name_here`

      If you want to add new pages or posts to your existing dagwood site, try `dagwood new post my_favorite_icecream`

      If you want to build your dagwood site, try `dagwood build`.

      If you want to preview your built website try `dagwood serve`.

      Each of these commands have their own help docs that go more in depth.
      try dagwood [command name] --help

      For example, getting the help specifically of the serve command:
      `dagwood serve --help`.
    ''');
}
