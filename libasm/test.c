#include <stdio.h>
#include <string.h>
#include <stdlib.h>


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
	printf("%d / %d\n", strcmp(str0, str0), ft_strcmp(str0, str0));
	printf("%d / %d\n", strcmp(str1, str1), ft_strcmp(str1, str1));
	printf("%d / %d\n", strcmp(str2, str1), ft_strcmp(str2, str1));
	printf("%d / %d\n", strcmp(str1, str2), ft_strcmp(str1, str2));
	printf("%d / %d\n", strcmp(str2, strnull), ft_strcmp(str2, strnull));
	printf("%d / %d\n", strcmp(strnull, strnull), ft_strcmp(strnull, strnull));
	printf("%d / %d\n", strcmp(str0, strnull), ft_strcmp(str0, strnull));
	printf("%d / %d\n", strcmp(strnull, str0), ft_strcmp(strnull, str0));
	printf("%d / %d\n", strcmp(str2, strweird), ft_strcmp(str2, strweird));
	printf("%d / %d\n", strcmp(strweird + 4, strweird + 6), ft_strcmp(strweird + 4, strweird + 6));
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
	printf("%zu\n", ft_strlen("hello"));
	ok3 = malloc(sizeof(char) * 5 + 1);
	printf("%s\n",ft_strcpy(ok3, "abcd"));
	printf("%s\n", ok3);
	ft_write(7, "ok\n", 3);
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