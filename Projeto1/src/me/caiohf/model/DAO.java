package me.caiohf.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import me.caiohf.model.Authentication;
import me.caiohf.model.Tasks;

public class DAO {
	String url = System.getenv("mysql_url");
	String user = System.getenv("mysql_user");
	String password = System.getenv("mysql_password");
	private Connection connection = null;
	public DAO() throws ClassNotFoundException, SQLException {
	 Class.forName("com.mysql.jdbc.Driver");
	 connection = DriverManager.getConnection(url, user, password);
	}
	
	
	public List<Tasks> getTasks() throws SQLException{
		List<Tasks> tasks = new ArrayList<Tasks>();
		PreparedStatement stmt = connection.prepareStatement("SELECT * FROM tasks");
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			Tasks task = new Tasks();
			task.setId(rs.getInt("id"));
			task.setCreator(rs.getString("creator"));
			task.setText(rs.getString("text"));
			task.setCategory(rs.getString("category"));
			Calendar data = Calendar.getInstance();
			data.setTime(rs.getDate("day"));
			task.setDay(data);
			tasks.add(task);
		}
		
		rs.close();
		stmt.close();
		
		return tasks;
	}
	
	public List<Tasks> getTasksByCategory(String category) throws SQLException{
		List<Tasks> tasks = new ArrayList<Tasks>();
		PreparedStatement stmt = connection.prepareStatement("SELECT * FROM tasks WHERE category=?");
		stmt.setString(1, category);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Tasks task = new Tasks();
			task.setId(rs.getInt("id"));
			task.setCreator(rs.getString("creator"));
			task.setText(rs.getString("text"));
			task.setCategory(rs.getString("category"));
			Calendar data = Calendar.getInstance();
			data.setTime(rs.getDate("day"));
			task.setDay(data);
			tasks.add(task);
		}
		
		rs.close();
		stmt.close();
		
		return tasks;
	}
	
	public List<Integer> getIds() throws SQLException{
		List<Integer> ids = new ArrayList<Integer>();
		PreparedStatement stmt = connection.prepareStatement("SELECT id FROM tasks");
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			ids.add(rs.getInt("id"));
		}
		
		rs.close();
		stmt.close();
		return ids;
	}
	
	public List<String> getCategorys() throws SQLException{
		List<String> categorys = new ArrayList<String>();
		PreparedStatement stmt = connection.prepareStatement("SELECT DISTINCT category from tasks");
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			categorys.add(rs.getString("category"));
		}
		
		rs.close();
		stmt.close();
		return categorys;
	}
	
	
	public Integer getTextSize() throws SQLException{
		List<String> data = new ArrayList<String>();
		String sql = "SELECT text FROM tasks";
		PreparedStatement stmt = connection.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			data.add(rs.getString("text"));
		}
		return data.size();
	}
	
	public Integer getTasksSize() throws SQLException{
		List<String> data = new ArrayList<String>();
		String sql = "SELECT id FROM tasks";
		PreparedStatement stmt = connection.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			data.add(rs.getString("id"));
		}
		return Integer.valueOf(data.get(data.size()-1));
	}
	
	
	public Integer getUsernameSize() throws SQLException{
		List<String> data = new ArrayList<String>();
		String sql = "SELECT username FROM authentication";
		PreparedStatement stmt = connection.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			data.add(rs.getString("username"));
		}
		return data.size();
	}
		
	
	
	public void addTask(Tasks task) throws SQLException {
		String sql = "INSERT INTO tasks" + "(creator, text, day, category) values(?,?,?,?)";
		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1, task.getCreator());
		stmt.setString(2, task.getText());
		java.sql.Date sqlDate = new java.sql.Date(task.getDay().getTime().getTime());
		stmt.setDate(3, sqlDate);
		stmt.setString(4, task.getCategory());
		stmt.execute();
		stmt.close();
	}
	
	public void updateTask(Tasks task) throws SQLException{
		String sql = "UPDATE tasks SET " + "text=?, category=? WHERE id=?";
		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1, task.getText());
		stmt.setString(2, task.getCategory());
		stmt.setInt(3, task.getId());
		stmt.execute();
		stmt.close();	
	}
	
	public void removeTask(Tasks task) throws SQLException{
		PreparedStatement stmt = connection.prepareStatement("DELETE FROM tasks WHERE id=?");
		stmt.setInt(1, task.getId());
		stmt.execute();
		stmt.close();
	}
	public Tasks selectTask(Integer id) throws SQLException{		
		String sql = "SELECT * from tasks WHERE id=?";
		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setInt(1, id);
		ResultSet rs = stmt.executeQuery();
		rs.next();
		Tasks task = new Tasks();
		task.setId(rs.getInt("id"));
		task.setCreator(rs.getString("creator"));
		task.setText(rs.getString("text"));
		task.setCategory(rs.getString("category"));
		Calendar data = Calendar.getInstance();
		data.setTime(rs.getDate("day"));
		task.setDay(data);
		stmt.close();
		return task;
		
		
		
		
		
	}
	
	
	public void addAuth(Authentication auth) throws SQLException, SQLIntegrityConstraintViolationException {
		String sql = "INSERT INTO authentication" + "(username,password) values(?,?)";
		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1,auth.getUsername());
		stmt.setString(2, auth.getPassword());
		stmt.execute();
		stmt.close();
	}
	
	public void deleteTask(Tasks task) throws SQLException{
		PreparedStatement stmt = connection.prepareStatement("DELETE FROM tasks WHERE id=?");
		stmt.setLong(1, task.getId());
		stmt.execute();
		stmt.close();
	}
	
	public boolean getAuthInformation(String user, String password) throws SQLException {
		String sql = "SELECT * FROM authentication where username=? AND password=?";
		PreparedStatement stmt = connection.prepareStatement(sql);
		stmt.setString(1, user);
		stmt.setString(2, password);
		ResultSet rs = stmt.executeQuery();
		if(!rs.next()) {
			return false;
		} else {
			return true;	
		}
		
	}

	public List<Tasks> getTasksSearched(String words) throws SQLException{
		List<Tasks> tasks = new ArrayList<Tasks>();
		PreparedStatement stmt = connection.prepareStatement("SELECT * FROM tasks WHERE text LIKE ? OR category LIKE ?");
		stmt.setString(1, "%" + words + "%");
		stmt.setString(2, "%" + words + "%");
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Tasks task = new Tasks();
			task.setId(rs.getInt("id"));
			task.setCreator(rs.getString("creator"));
			task.setText(rs.getString("text"));
			task.setCategory(rs.getString("category"));
			Calendar data = Calendar.getInstance();
			data.setTime(rs.getDate("day"));
			task.setDay(data);
			tasks.add(task);
		}
		
		rs.close();
		stmt.close();
		
		return tasks;
	}
	
	
	
	public void close() throws SQLException {
		connection.close();
		}


}
