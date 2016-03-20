# Contributing

If you are reading this, you are likely wanting to help improve
vim-root. Please fork a copy of the project's `develop` branch, and hack
away.

However, it would help both you and the maintainers if you open and
issue to [discuss it][] before you attempt a pull request. We may
already be working on your, or a similar, feature.

We may simply not agree with your suggestion. If this is the case, do
not fret; you can still implement it yourself in your own fork, or
simply just on your local copy.

Everyone has their own style of programming. It arguably does not matter
the intermediate steps you take from start to pull request, so long as
the commits are clear and the final commit is in our style.

However you would likely find it easier to write in our style from the
get-go.

[discuss it]: https://www.igvita.com/2011/12/19/dont-push-your-pull-requests/

## git-flow

We use Vincent Driessen's branching model, [git-flow][]. It might see
like overkill for a small project, but ensures a semantic and well
organised code base.

Since his article, Vincent has produced a number of [scripts][] that
speed up the git-flow process. We use the defaults of those scripts with
the exception of the version prefix, we use `v`.

If it seems like a lot to learn, do not worry. Everything branches
from the `develop` branch, and new features have their own branch
`feature/*`; that is all you really need to know to help us.

[git-flow]: http://nvie.com/posts/a-successful-git-branching-model/
[scripts]: https://github.com/nvie/gitflow

## Line Length

Some prefer to have a single line that wraps in their editor, others
prefer a break ever 80--120 characters. We prefer the latter. Please try
to keep your *maximum* length of a line to **72--80** characters. It
doesn't take too long, and it makes code more readable.

## Indentation

As a tab is not consistent between operating systems, editors, and user
preferences; we use **soft-tabs**, *i.e.*, spaces, of length **4**
characters.

## Commit Messages

Tim Pope is an inspiration to most Vim users, therefore we stick to his
convention of commits. No one likes [crappy commits][], therefore please
refer to Tim's infamous [blog post][] for the preferred style of commit
messages.

[crappy commits]: http://stopwritingramblingcommitmessages.com/
[blog post]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
