package me.caiohf.controller;

import java.sql.SQLException;
import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import me.caiohf.model.DAO;
import me.caiohf.model.Authentication;
import me.caiohf.model.Tasks;

@Controller
public class MainController {
	@RequestMapping("/")
	public String execute() {
		System.out.println("Iniciado");
		return "auth";
	}

	@RequestMapping("showPage")
	public String goToPageShow() {
		return "show";
	}

	@RequestMapping("authPage")
	public String goToPageAuth() {
		return "auth";
	}

	@RequestMapping("login")
	public String login(Authentication auth, HttpSession session) {
		try {
			DAO dao = new DAO();
			boolean result = dao.getAuthInformation(auth.getUsername(), auth.getPassword());
			if (result == true) {
				session.setAttribute("username", auth.getUsername());
				System.out.println("Informações corretas, logado.");
				return "show";
			} else {
				System.out.println("Falha na autenticação!");
			}
		} catch (SQLException e) {
			;
		} catch (NullPointerException e) {
			;
		} catch (ClassNotFoundException e) {
			;
		}
		return "auth";
	}

	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "auth";
	}

	@RequestMapping("signupPage")
	public String goToPageSignup() {
		return "signup";
	}

	@RequestMapping("signup")
	public String signup(Authentication auth) {
		try {
			DAO dao = new DAO();
			if (auth.getUsername().isEmpty() || auth.getPassword().isEmpty()) {
				System.out.println("Nome de usuário ou senha não foram preenchidos.");
			} else {
				dao.addAuth(auth);
				System.out.println("Cadastrado!");
				return "auth";
			}
		} catch (SQLException e) {
			;
		} catch (NullPointerException e) {
			;
		} catch (ClassNotFoundException e) {
			;
		}
		return "signup";
	}

	@RequestMapping("create")
	public String create(Tasks task) {
		try {
			DAO dao = new DAO();
			Calendar calendar = Calendar.getInstance();
			if (task.getText().isEmpty() || task.getCategory().isEmpty()) {
				System.out.println("Não preenchido.");
			} else {
				task.setDay(calendar);
				dao.addTask(task);
			}
		} catch (SQLException e) {
			;
		} catch (NullPointerException e) {
			;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return "redirect:showPage";
	}

	@RequestMapping("filter")
	public String filter(Tasks task, RedirectAttributes redirectAttributes) {
		String category = task.getCategory();
		try {
			if (category != null) {
				redirectAttributes.addAttribute("category", category);
				return "categoryFilter";
			}

		} catch (NullPointerException e) {
			;
		}
		return "show";
	}

	@RequestMapping("delete")
	public String delete(Tasks task, @RequestParam(value = "removeCheck", required = false) boolean checkBox) {
		try {
			if(checkBox) {
				DAO dao = new DAO();
				dao.removeTask(task);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return "redirect:showPage";

	}
	
	@RequestMapping("editPage")
	public String goToEditPage() {
		return "edit";
	}
	@RequestMapping("selectIdToEdit")
	public String selectId(RedirectAttributes redirectAttributes, @RequestParam Integer idSelector) {
		redirectAttributes.addAttribute("idToEdit", idSelector);
		return "redirect:editPage";
	}
	
	@RequestMapping("edit")
	public String edit(Tasks task) {
		try{
		 	DAO dao = new DAO();
	 		task.setText(task.getText());
		 	task.setCategory(task.getCategory());
		 	dao.updateTask(task);	
	 	 } catch(SQLException e){
	 		 ;
	 	 } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return "redirect:showPage";
	}
	
	@RequestMapping("searchPage")
	public String goToSearchPage() {
		return "search";
	}
	
	@RequestMapping("search")
	public String search(RedirectAttributes redirectAttributes, @RequestParam String textSearch) {
		redirectAttributes.addAttribute("wordSearch", textSearch);
		return "redirect:searchPage";
		
	}
}
