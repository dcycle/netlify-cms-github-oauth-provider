if [ ! -f .env ]; then 
  >&2 echo ""
  >&2 echo "Please create an env file like this:"
  >&2 echo ""
  cat ./examples/env.txt
  >&2 echo ""
  exit 1;
fi

source .env
