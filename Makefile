CC=swiftc
FLAGS= -o
RM= rm -f
TMP= *~
EXEC=GameFactoryRPGExec
SRCS=	GameFactoryRPG/*.swift GameFactoryRPG/Enum/*.swift GameFactoryRPG/Heroes/*.swift GameFactoryRPG/Utils/*.swift

$(EXEC):
	$(CC) $(SRCS) $(FLAGS) $(EXEC)

all: $(EXEC)

clean:
	$(RM) $(TMP)

fclean: clean
	$(RM) $(EXEC)

re: fclean all
