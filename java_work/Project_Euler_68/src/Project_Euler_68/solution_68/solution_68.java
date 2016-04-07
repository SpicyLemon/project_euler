package Project_Euler_68.solution_68;
import java.util.*;
import java.lang.StringBuilder;

public class solution_68 {
	public static void main ( String [] args ) {
		System.out.println("Starting");
		// Get all lists of the inner numbers
		List<List<Integer>> innerNums = getPermutations(new ArrayList<Integer>(Arrays.asList(1, 2, 3, 4, 5)));
		// Get all lists of the outer numbers
		List<List<Integer>> outerNums = getPermutations(new ArrayList<Integer>(Arrays.asList(7, 8, 9, 10)));
		for (List<Integer> outerNum : outerNums) {
			outerNum.add(0, 6);
		}
		
		
		List<String> answers = new ArrayList<String>();
		for (List<Integer> outerList: outerNums) {
			for (List<Integer> innerList: innerNums) {
				if (isMagic(outerList, innerList)) {
					answers.add(answerFormat(outerList, innerList));
				}
			}
		}
		
		for (String answer : answers) {
			System.out.println(answer);
		}		
		
		System.out.println("Done.");
	}
	
	public static boolean isMagic(List<Integer> outer, List<Integer> inner) {
		boolean retval = true;
		int linesTotal = 0;
		int n = outer.size();
		for(int i = 0; i < n; i++) {
			int lineTotal = outer.get(i)
			              + inner.get(i)
			              + inner.get((i + 1) % n);
			if (linesTotal == 0) {
				linesTotal = lineTotal;
			}
			else if (linesTotal != lineTotal) {
				retval = false;
				break;
			}
		}
		return retval;
	}
	
	public static String answerFormat(List<Integer> outer, List<Integer> inner) {
		StringBuilder retval = new StringBuilder();
		int n = outer.size();
		for(int i = 0; i < n; i++) {
			retval.append(outer.get(i));
			retval.append(inner.get(i));
			retval.append(inner.get((i + 1) % n));
		}
		return retval.toString();
	}
	
	public static <T> String listJoin(List<T> list) {
		return listJoin(list, "");
	}
	public static <T> String listJoin(List<T> list, String delimitor) {
		StringBuilder retval = new StringBuilder();
		for (int i = 0; i < list.size(); i++) {
			if (i != 0) {
				retval.append(delimitor);
			}
			retval.append(list.get(i).toString());
		}
		return retval.toString();
	}
	
	public static <T> List<List<T>> getPermutations(List<T> list) {
		return getPermutations(new ArrayList<T>(), list);
	}
	
	private static <T> List<List<T>> getPermutations(List<T> prefix, List<T> suffix) {
		int n = suffix.size();
		List<List<T>> retval = new ArrayList<List<T>>();
		if (n == 0) {
			retval.add(prefix);
		}
		else {
			for (int i = 0; i < n; i++) {
				List<T> newPrefix = new ArrayList<T>(prefix);
				List<T> newSuffix = new ArrayList<T>(suffix);
				newPrefix.add(newSuffix.remove(i));
				retval.addAll(getPermutations(newPrefix, newSuffix));
			}
		}
		return retval;
	}
}
