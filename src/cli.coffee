program   = require 'commander'
GitAction = require './git_action'


program.option '-r, --root [root]',              'Specify the root repo. Default .'
program.option '-m, --message [commit message]', 'Specify commit message'


program
    .command('init')
    .description('Assemble the initial .git_nez control file into [root]')
    .action -> GitAction.assign(program).init arguments

program
    .command('status')
    .description('Git status across all nested git repos')
    .action -> GitAction.assign(program).status arguments

program
    .command('clone')
    .description('Git clone all missing nested git repos')
    .action -> GitAction.assign(program).clone arguments

program 
    .command('commit')
    .description('Git commit across all nested repos with staged changes.')
    .action -> GitAction.assign(program).commit arguments

program
    .command('pull')
    .description('Git pull across all nested git repos not up-to-date with .git_root')
    .action -> GitAction.assign(program).pull arguments

program
    .command('push')
    .description('Git push across all nested git repos pending commits and update .git_root')
    .action -> GitAction.assign(program).push arguments


program.parse process.argv

GitAction.showError() if GitAction.error