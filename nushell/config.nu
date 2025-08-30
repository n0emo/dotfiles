# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# Source an environment from a batch file
def --env sourcebat [
  ...cmd: string # The batch command to run
] {
  let tmp = mktemp -t

  let cmd = ($cmd | append ["&&" "set" $">($tmp)"])

  # Run the command and print its output as it is running.
  # `str join` will block until EOF.
  let stdout = run-external cmd.exe /c ...$cmd | each { |line| print -n $line; $line } | str join

  let vars = open $tmp
  rm $tmp # Clean up the temp file.

  # Source: https://stackoverflow.com/questions/77383686/set-environment-variables-from-file-of-key-value-pairs-in-nu
  # Convert the output of `set` into a record.
  def "from env" []: string -> record {
    lines
      | split column '#'
      | get column1
      | where {($in | str length) > 0}
      | parse "{key}={value}"
      | update value {str trim -c '"'}
      | transpose -r -d
  }

  let vars = $vars | from env | transpose | where { |in| $in.column0 != 'PWD' and $in.column0 != 'CURRENT_FILE' and $in.column0 != 'FILE_PWD' } | transpose -r -d;
  load-env $vars
}

def --env vsenv [ ] {
    sourcebat "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Auxiliary/Build/vcvars64.bat"
}

$env.config.buffer_editor = "nvim"

$env.config.show_banner = false
