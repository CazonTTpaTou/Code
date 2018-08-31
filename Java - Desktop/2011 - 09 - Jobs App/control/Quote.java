package control;

import java.util.*;

public class Quote {

	public static String addSlashes(String str){
	if(str==null) return "";

	StringBuffer s = new StringBuffer ((String) str);
	for (int i = 0; i < s.length(); i++)
	if (s.charAt (i) == '\'')
	s.insert (i++, '\\');
	return s.toString();
	}
}
