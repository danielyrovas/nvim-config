---@diagnostic disable: undefined-global

return {
    s(
        "zellij layout template",
        fmt(
            [[layout {
    tab name="Tab #1" hide_floating_panes=true {
        pane split_direction="vertical" {
            pane <> focus=true
            pane stacked=true {
                pane command="zsh" expanded=true {
                    args "-c" "direnv exec . <>"
                    start_suspended true
                }
                pane command="zsh" {
                    args "-c" "direnv exec . <>"
                    start_suspended true
                }
            }
        }
        pane size=1 borderless=true {
            plugin location="zellij:compact-bar"
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // default layout boilerplate
    ////////////////////////////////////////////////////////////////////////////
    new_tab_template {
        pane
        pane size=1 borderless=true {
            plugin location="compact-bar"
        }
    }
    swap_tiled_layout name="vertical" {
        tab max_panes=4 {
            pane {
                pane split_direction="vertical" {
                    pane
                    pane {
                        children
                    }
                }
            }
            pane size=1 borderless=true {
                plugin location="compact-bar"
            }
        }
        tab max_panes=7 {
            pane {
                pane split_direction="vertical" {
                    pane {
                        children
                    }
                    pane {
                        pane
                        pane
                        pane
                        pane
                    }
                }
            }
            pane size=1 borderless=true {
                plugin location="compact-bar"
            }
        }
        tab max_panes=11 {
            pane {
                pane split_direction="vertical" {
                    pane {
                        children
                    }
                    pane {
                        pane
                        pane
                        pane
                        pane
                    }
                    pane {
                        pane
                        pane
                        pane
                        pane
                    }
                }
            }
            pane size=1 borderless=true {
                plugin location="compact-bar"
            }
        }
    }
    swap_tiled_layout name="horizontal" {
        tab max_panes=3 {
            pane {
                pane
                pane
            }
            pane size=1 borderless=true {
                plugin location="compact-bar"
            }
        }
        tab max_panes=7 {
            pane {
                pane {
                    pane split_direction="vertical" {
                        children
                    }
                    pane split_direction="vertical" {
                        pane
                        pane
                        pane
                        pane
                    }
                }
            }
            pane size=1 borderless=true {
                plugin location="compact-bar"
            }
        }
        tab max_panes=11 {
            pane {
                pane {
                    pane split_direction="vertical" {
                        children
                    }
                    pane split_direction="vertical" {
                        pane
                        pane
                        pane
                        pane
                    }
                    pane split_direction="vertical" {
                        pane
                        pane
                        pane
                        pane
                    }
                }
            }
            pane size=1 borderless=true {
                plugin location="compact-bar"
            }
        }
    }
    swap_tiled_layout name="stacked" {
        tab min_panes=4 {
            pane {
                pane split_direction="vertical" {
                    pane
                    pane stacked=true {
                        children
                    }
                }
            }
            pane size=1 borderless=true {
                plugin location="compact-bar"
            }
        }
    }
    swap_floating_layout name="staggered" {
        floating_panes
    }
    swap_floating_layout name="enlarged" {
        floating_panes max_panes=10 {
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 1
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 2
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 3
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 4
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 5
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 6
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 7
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 8
            }
            pane {
                height "90%"
                width "90%"
                x "5%"
                y 9
            }
            pane focus=true {
                height "90%"
                width "90%"
                x 10
                y 10
            }
        }
    }
    swap_floating_layout name="spread" {
        floating_panes max_panes=1 {
            pane {
                x "50%"
                y "50%"
            }
        }
        floating_panes max_panes=2 {
            pane {
                width "45%"
                x "1%"
                y "25%"
            }
            pane {
                width "45%"
                x "50%"
                y "25%"
            }
        }
        floating_panes max_panes=3 {
            pane focus=true {
                height "45%"
                width "45%"
                y "55%"
            }
            pane {
                width "45%"
                x "1%"
                y "1%"
            }
            pane {
                width "45%"
                x "50%"
                y "1%"
            }
        }
        floating_panes max_panes=4 {
            pane {
                height "45%"
                width "45%"
                x "1%"
                y "55%"
            }
            pane focus=true {
                height "45%"
                width "45%"
                x "50%"
                y "55%"
            }
            pane {
                height "45%"
                width "45%"
                x "1%"
                y "1%"
            }
            pane {
                height "45%"
                width "45%"
                x "50%"
                y "1%"
            }
        }
    }
}]],
            { i(1, [[edit=""]]), i(2, ""), i(3, "") },
            { delimiters = "<>" }
        )
    ),
}
