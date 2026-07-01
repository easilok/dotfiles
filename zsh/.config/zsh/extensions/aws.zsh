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
}
