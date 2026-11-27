awsprofile() {
    local profile

    profile=$(
        sed -nE \
            -e 's/^\[default\]$/default/p' \
            -e 's/^\[profile (.+)\]$/\1/p' \
            ~/.aws/config |
        fzf
    ) || return

    export AWS_PROFILE="$profile"

    print "Set AWS_PROFILE to $AWS_PROFILE"
    identity=$(aws sts get-caller-identity)

    if [[ $? -eq 255 ]]; then
    # if [[ $identity == *"sso: Token has expired"* ]]; then
        aws sso login
    fi
}
