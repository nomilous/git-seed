program   = require 'commander'
colors    = require 'colors'
GitAction = require './git_action'

notice    = require 'notice'
console.log 'TODO: notice routability'
notice.configure
    source: 'git-seed'

    #
    # messenger: require 'notice-cli'
    # 
    # temporary local messenger
    # 

    messenger: (msg) -> 

        description = msg.content.description
        detail      = msg.content.detail

        switch msg.context.type

            when 'event' then label = "[#{msg.content.label}]".bold
            when 'info'  then label = "(#{msg.content.label})"
            else label = "#{msg.content.label}"

        switch msg.context.tenor

            when 'good' then label = label.green
            when 'bad' then label = label.red
            else label = label.bold

        console.log "%s - %s", label, description
        console.log detail if detail

        # if msg.content.label == 'seed update' 
        #     console.log JSON.stringify msg.content.seed


program.option '    --package-manager [package_manager]',  'Calls package manager after each clone/pull (default npm)'       
program.option '-m, --message         [commit_message]',   'Specify commit message'


#
# TODO: Scaled deployability and content distribution (proxy trees).
#

program.option '-d, --as-daemon       [config_file]',    '[NOT YET IMPLEMENTED] Run as a daemon.'
program.option '-p, --as-proxy        [config_file]',    '[NOT YET IMPLEMENTED] Run as a distribution proxy.'


program
    .command('init')
    .description('Assemble the initial .nez_tree control file into [root]')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).init arguments

program
    .command('status')
    .description('Git status across all nested git repos')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).status arguments

program
    .command('clone')
    .description('Git clone all missing nested git repos')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).clone arguments

program 
    .command('commit')
    .description('Git commit across all nested repos with staged changes.')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).commit arguments

program
    .command('pull')
    .description('Git pull across all nested git repos.')
    .action -> 

        GitAction.configure(

            program
            success = -> console.log 'DONE', arguments
            error   = -> console.log 'ERROR', arguments
            notice

        ).pull arguments


# program
#     .command('push')
#     .description('[PENDING] Git push across all nested git repos (per .git-seed)')
#     .action -> 
#
#         GitAction.configure(
#
#             program
#             success = -> console.log 'DONE', arguments
#             error   = -> console.log 'ERROR', arguments
#             notice
#
#         ).push arguments
# 
# program
#     .command('watch')
#     .description('[PENDING] Attach console to github rss feeds for all repos in .git-seed')
#     .action -> 
#
#         GitAction.configure(
#
#             program
#             success = -> console.log 'DONE', arguments
#             error   = -> console.log 'ERROR', arguments
#             notice
#
#         ).watch arguments


program.parse process.argv

if GitAction.error

    GitAction.showError()
    process.exit 1

