##
## EPITECH PROJECT, 2020
## evalexpr
## File description:
## Makefile
##

SRC	=	src/EvalExpr.hs	\
		src/Utils.hs	\
		src/ShuntingYard.hs \
		src/CheckArg.hs

NAME	=	funEvalExpr

all:	$(NAME)

$(NAME):	$(SRC)
	@stack build --copy-bins --local-bin-path .
	@printf "\033[39;1m%s \033[32;1m[Compiled]\033[39;1m\n" $<
	@mv EvalExpr-exe $(NAME)
	@printf "\n \033[33;1m[Success]\033[39;1m Compilation done\n\n"

clean:
	@stack clean
	@printf "\033[31;1m[Clean] \033[39;1m\n" $(OBJS)

fclean:	clean
	@rm -f $(NAME)
	@printf "\033[31;1m[All Clean] \033[39;1m\n" $(NAME)

re:	fclean all

.PHONY : clean fclean re