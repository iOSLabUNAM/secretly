declared_trivial = github.pr_title.include? '#trivial'

warn('PR is classed as Work in Progress') if github.pr_title.include? '[WIP]'

case github.lines_of_code
when 1..3
  message('😒 Is it really necessary?')
when 3..500
  warn("Please provide a summary in the Pull Request description") if github.pr_body.length > 10
else
  fail('Your pull request is too big')
end

swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files inline_mode: true

commit_lint.check
