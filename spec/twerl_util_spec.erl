-module(twerl_util_spec).
-include_lib("espec.hrl").

spec() ->
    describe("twerl util", fun() ->
            describe("#generate_headers", fun() ->
                    it("should generate Host and User-Agent headers", fun() ->
                                Result = twerl_util:generate_headers(),
                                Expected = [
                                    {"Host", "api.twitter.com"},
                                    {"User-Agent", "Twerl"}
                                ],

                                ?assertEqual(Expected, Result)
                        end)
                end),

            describe("#userids_to_follow", fun() ->
                    it("should return an error when no users are passed", fun() ->
                                Result = twerl_util:userids_to_follow([]),
                                Expected = {error, no_args_passed},

                                ?assertEqual(Expected, Result)
                        end),

                    it("should return the correct url for one user", fun() ->
                                Result = twerl_util:userids_to_follow(["1"]),
                                Expected = {ok, "follow=1"},
                                ?assertEqual(Expected, Result)
                        end),

                    it("should return the correct url for two users", fun() ->
                                Result = twerl_util:userids_to_follow(["1", "2"]),
                                Expected = {ok, "follow=1,2"},
                                ?assertEqual(Expected, Result)
                        end)
                end)
        end).
