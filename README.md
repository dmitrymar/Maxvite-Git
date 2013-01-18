git add filename (stage file)

git commit -m "some text describing changes"

git remote add origin git@github.com:dmitrymar/try_git.git
(To push our local repo to the GitHub server we'll need to add a remote repository.

This command takes a remote name and a repository URL, which in your case is git@github.com:dmitrymar/try_git.git.)

git push -u origin master
(The push command tells Git where to put our commits when we're ready. So let's push our local changes to our origin repo (on GitHub).

The name of our remote is origin and the default local branch name is master. The -u tells Git to remember the parameters, so that next time we can simply run git push and Git will know what to do. Go ahead and push it!)