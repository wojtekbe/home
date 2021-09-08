function fish_prompt_jobs
    set j (jobs | wc -l)
    if [ $j = '0' ]
      echo ''
    else
      echo ' '$j
    end
end

function fish_prompt --description 'Write out the prompt'
	set -l color_cwd
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '$'
    end

    echo -n -s (set_color 6D3CFF) "$USER" @ (prompt_hostname) (set_color FF0000) (fish_prompt_jobs) ' ' (set_color $color_cwd) (prompt_pwd) (set_color 404040) (set_color 606060) "$suffix "
end
