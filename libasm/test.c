#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/errno.h>

typedef struct		s_list
{
	void			*data;
	struct s_list	*next;
}					t_list;

size_t		ft_strlen(const char *s);
int		ft_strcmp(const char *s1, const char *s2);
char *ft_strcpy(char * dst, const char * src);
ssize_t ft_write(int fildes, const void *buf, size_t nbyte);
char *ft_strdup(const char *s1);
int	ft_atoi_base(char *s1, char *s2);
void	ft_list_push_front(t_list **alst, void *new);
int		ft_list_size(t_list *lst);
void ft_list_sort(t_list **begin_list, int (*cmp)());
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

void display_list(t_list **lst)
{
	t_list *elem;

	elem = *lst;
	while(elem)
	{
		printf("%s\n",elem->data);
		elem = elem->next;
	}

}

void free_function(void *ptr)
{
	free(ptr);
}

void test_strcpy(char *ok3)
{
	printf("//////////TESTS STRCPY//////////\n");
	ok3 = malloc(sizeof(char) * 5 + 1);
	printf("%s\n", ft_strcpy(ok3, "abcd"));
	printf("%s\n", ok3);
	free(ok3);
	ok3 = malloc(sizeof(char) * 83 + 1);
	printf("%s\n", ft_strcpy(ok3, "Ligue des Champions : Barcelone - Paris SG\nSans Neymar ni Di Maria, comment faire ?"));
	printf("%s\n", ok3);
	free(ok3);
	ok3 = malloc(sizeof(char) * 1);
	printf("%s\n", ft_strcpy(ok3, ""));
	printf("%s\n", ok3);
	ok3 = malloc(sizeof(char) * 7);
	printf("%s\n", ft_strcpy(ok3, "ah\0\0\0l"));
	printf("%s\n", ok3);
}

void test_strlen(void)
{
	char *adam;

	adam = "Adam a longtemps été fier de son père, un braqueur de l'ancienne école. Très vite, lui qui voulait marcher sur ses traces constate que la vie de voyou nest pas héréditaire.";
	printf("//////////TESTS STRLEN//////////\n");
	printf("hello : %zu\n", ft_strlen("hello"));
	printf(" : %zu\n", ft_strlen(""));
	printf("%s : %zu / %zu\n", adam, ft_strlen(adam), strlen(adam));

}

void test_strcmp(void)
{
	char *str1;
	char *str2;
	char *strnull;
	char *strweird;
	char *str0;

	str1 = "abcd";
	str2 = "abricotiers";
	strweird = "^àç!è§('ç!àé";
	str0 = "";
	printf("//////////TESTS STRCMP//////////\n");
	printf("%s et %s : %d / %d\n", str0, str0, strcmp(str0, str0), ft_strcmp(str0, str0));
	printf("%s et %s : %d / %d\n", str1, str1, strcmp(str1, str1), ft_strcmp(str1, str1));
	printf("%s et %s : %d / %d\n", str2, str1, strcmp(str2, str1), ft_strcmp(str2, str1));
	printf("%s et %s : %d / %d\n", str1, str2, strcmp(str1, str2), ft_strcmp(str1, str2));
	printf("%s et %s : %d / %d\n", str2, strweird, strcmp(str2, strweird), ft_strcmp(str2, strweird));
	printf("%s et %s : %d / %d\n", strweird + 5, strweird + 6, strcmp(strweird + 5, strweird + 6), ft_strcmp(strweird + 5, strweird + 6));
}

void test_write(void)
{
	int fd;
	char *txt;
	printf("//////////TESTS WRITE//////////\n");
	ft_write(1, "ok\n", 3);
	printf("***Creation d'un ficher test out_write\n");
	fd = open("out_write", O_WRONLY | O_TRUNC | O_CREAT, 0777);
	printf("***Ecriture puis lecture\n");
	txt = "Extraire la texture d'un jean denim dans les moindres détails pour la transformer en un filtre 3d, c'est technique. Alors pour la sortie de la nouvelle collection responsable Lee Jeans Europe et H&M, Nassim Bouaza et Meric Chaperon du studio Plus Mûrs nous montre tout. Le filtre est à essayer sur notre Insta\n";
	ft_write(fd, txt, ft_strlen(txt));
	system("cat out_write");
	close(fd);
	printf("***Fermeture du fichier\n");
	printf("errno avant write dans fd ferme : %d\n", errno);
	//ft_write(fd, "euh", 3);
	printf("errno apres %d : %s\n", errno, strerror(errno));
}
 
int main(void)
{
	char *ok = "zippy";
	char *ok2 = "koppy";
	char *ok3;
	char *ok4;
	t_list testons;
	t_list testons2;
	t_list testons3;
	t_list *list;
	t_list *new_list;

	test_strcmp();
	test_strlen();
	test_strcpy(ok3);
	test_write();
	ok4 = ft_strdup(ok);
	printf("dup\n");
	printf("%s\n", ok4);
	printf("%d\n",atoi("1"));
	printf("%d\n", ft_atoi_base(" 755x+","01234567"));
	testons.data = ok3;
	testons2.data = ok2;
	testons.next = &testons2;
	testons3.data = "oui";
	testons3.next = NULL;
	list = &testons;
	display_list(&list);
	printf("pointeur list : %p, elem 1 : %p, elem 2 : %p, elem 3 : %p\n", &list, &testons, &testons2, &testons3);
	ft_list_push_front(&list, ok4);
	printf("checkpoint\n");
	display_list(&list);
	printf("list size : %d\n", ft_list_size(list));
	ft_list_sort(&list, &ft_strcmp);
	//free(list->data);
	display_list(&list);
	display_list(&list);
	printf("checkpoint2\n");
	ft_list_push_front(&new_list, ft_strdup("zzzzz"));
	ft_list_push_front(&new_list, ok4);
	ft_list_push_front(&new_list, ft_strdup("pour une fois"));
	ft_list_push_front(&new_list, ft_strdup("zippy"));
	ft_list_push_front(&new_list, ft_strdup("comman"));
	ft_list_push_front(&new_list, ft_strdup("yes"));
	ft_list_push_front(&new_list, ok3);
	printf("//////////////////\n");
	//ft_list_sort(&new_list, &ft_strcmp);
	display_list(&new_list);
	printf("//////////////////\n");	
	ft_list_remove_if(&new_list, "zippy", &ft_strcmp, &free_function);
	display_list(&new_list);
}