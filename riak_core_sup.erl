%%%'   LICENSE
{{license}}
%%%.
%%%'   HEADER
%%% @copyright {{copyright_year}} {{author_name}}
%%% @doc {{description}}
%%% @end
-module({{appid}}_sup).

-behaviour(supervisor).

%% Public API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%%%.
%%%'   PUBLIC API

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%%%.
%%%'   CALLBACKS

%% @private
init(_Args) ->
    VMaster = { {{appid}}_vnode_master,
                  {riak_core_vnode_master, start_link, [{{appid}}_vnode]},
                  permanent, 5000, worker, [riak_core_vnode_master]},

    { ok,
        { {one_for_one, 5, 10},
          [VMaster]}}.

%%%.
%%% vim: set filetype=erlang tabstop=4 foldmarker=%%%',%%%. foldmethod=marker:
