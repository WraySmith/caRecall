# How to contribute to caRecall

This project was made as an API wrapper for the Canda [Vehicle Recall Database API](https://tc.api.canada.ca/en/detail?api=VRDB)

## Testing

Unit tests should be written for all package functions.

## Submitting changes

Please send a [GitHub Pull Request to caRecall](https://github.com/WraySmith/caRecall/pull/new/master) with a clear list of what you've done (read more about [pull requests](http://help.github.com/pull-requests/)). When you send a pull request, we will love you forever if you include RSpec examples. We can always use more test coverage. Please follow our coding conventions (below) and make sure all of your commits are atomic (one feature per commit).

Always write a clear log message for your commits. One-line messages are fine for small changes, but bigger changes should look like this:
```
    $ git commit -m "A brief summary of the commit
    > 
    > A paragraph describing what changed and its impact."
```
## Coding conventions

This code should conform to the tidyverse style guide.
Text that contains valid R code should be marked as such using backticks. This includes:

- Function names, which should be followed by (), e.g. tibble().
- Function arguments, e.g. na.rm.
- Values, e.g. TRUE, FALSE, NA, NaN, ..., NULL
- Literal R code, e.g. mean(x, na.rm = TRUE)
- Class names, e.g. “a tibble will have class tbl_df …”
- Do not use code font for package names. If the package name is ambiguous in the context, disambiguate with words, e.g. “the foo package”. Do not capitalize the function name if it occurs at the -start of a sentence.

See https://style.tidyverse.org/documentation.html for more info.

Although the style guide explains the “what” and the “why”, another important decision is how to enforce a specific code style. For this we recommend the styler package (https://styler.r-lib.org); its default behaviour enforces the tidyverse style guide. There are many ways to apply styler to your code, depending on the context:

- styler::style_pkg() restyles an entire R package.
- styler::style_dir() restyles all files in a directory.
- usethis::use_tidy_style() is wrapper that applies one of the above functions depending on whether the current project is an R package or not.
- styler::style_file() restyles a single file.
- styler::style_text() restyles a character vector.


Thanks,
Nathan Smith, Ryan Koenig, Mitch Harris