function add_to_path {
  local to_add="${1?usage: add_to_path <to_add> [prepend]}"

  case ":$PATH:" in
    *":$to_add:"*) ;;
    *) 
      if [ "$2" = prepend ]; then
        export PATH="$to_add:$PATH"
      else 
        export PATH="$PATH:$to_add"
      fi
      ;;
  esac
}
